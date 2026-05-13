#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p "python3.withPackages(ps: with ps; [ pillow numpy scikit-learn ])"
"""
Classify wallpapers by color scheme so a second one will visually match a
chosen first (useful when one feeds matugen and the other shows on a second
monitor).

Build the index once (re-run when you add new wallpapers):
    ./clustering.py ~/hyprflake/assets/wallpapers --clusters 6

Given one wallpaper, print N matching wallpapers, one per line (the main op):
    ./clustering.py --match ~/hyprflake/assets/wallpapers/foo.jpg --count 2

Print a fully-random matching pair (two lines):
    ./clustering.py --pair
"""
import argparse
import colorsys
import json
import random
import sys
from pathlib import Path

import numpy as np
from PIL import Image
from sklearn.cluster import KMeans

IMG_EXTS = {".jpg", ".jpeg", ".png", ".webp", ".bmp"}


def srgb_to_lab(rgb01: np.ndarray) -> np.ndarray:
    """Vectorized sRGB (0-1) -> CIE LAB (D65)."""
    a = 0.055
    lin = np.where(rgb01 <= 0.04045, rgb01 / 12.92, ((rgb01 + a) / (1 + a)) ** 2.4)
    m = np.array([[0.4124564, 0.3575761, 0.1804375],
                  [0.2126729, 0.7151522, 0.0721750],
                  [0.0193339, 0.1191920, 0.9503041]])
    xyz = lin @ m.T / np.array([0.95047, 1.0, 1.08883])
    eps, kap = 216 / 24389, 24389 / 27
    f = np.where(xyz > eps, np.cbrt(xyz), (kap * xyz + 16) / 116)
    L = 116 * f[..., 1] - 16
    A = 500 * (f[..., 0] - f[..., 1])
    B = 200 * (f[..., 1] - f[..., 2])
    return np.stack([L, A, B], axis=-1)


def normalize_features(X: np.ndarray) -> np.ndarray:
    """Scale axes to ~[0,1] and up-weight hue (a,b). Same transform at index + match time."""
    X = X.astype(np.float32).copy()
    if X.ndim == 1:
        X = X[None, :]
    X[:, 0] /= 100      # L
    X[:, 1] /= 128      # a
    X[:, 2] /= 128      # b
    X[:, 3] /= 100      # sat
    X[:, 4] /= 100      # val
    X[:, 1] *= 2.0
    X[:, 2] *= 2.0
    return X


def color_signature(img_path: Path, k: int = 5, resize: int = 150) -> np.ndarray:
    """Return [L, a, b, sat%, val%] weighted by dominant-cluster size."""
    img = Image.open(img_path).convert("RGB")
    img.thumbnail((resize, resize))
    px = np.asarray(img).reshape(-1, 3).astype(np.float32) / 255.0

    km = KMeans(n_clusters=k, n_init=4, random_state=0).fit(px)
    centers = km.cluster_centers_
    _, counts = np.unique(km.labels_, return_counts=True)
    w = counts / counts.sum()

    lab = srgb_to_lab(centers)
    avg_lab = (lab * w[:, None]).sum(axis=0)

    hsv = np.array([colorsys.rgb_to_hsv(*c) for c in centers])
    avg_sat = (hsv[:, 1] * w).sum() * 100
    avg_val = (hsv[:, 2] * w).sum() * 100
    return np.concatenate([avg_lab, [avg_sat, avg_val]])


def label_centroid(c: np.ndarray) -> str:
    """Build a human-readable name from centroid [L, a, b, sat, val]."""
    _, a, b, s, v = c
    parts = []
    if v < 30:    parts.append("dark")
    elif v > 75:  parts.append("light")
    if s < 20:    parts.append("muted")
    elif s > 55:  parts.append("vibrant")
    if s >= 10:
        ang = np.degrees(np.arctan2(b, a)) % 360
        if   ang < 35 or ang >= 340: parts.append("red")
        elif ang < 70:               parts.append("orange")
        elif ang < 100:              parts.append("yellow")
        elif ang < 165:              parts.append("green")
        elif ang < 220:              parts.append("teal")
        elif ang < 290:              parts.append("blue")
        else:                        parts.append("magenta")
    return " ".join(parts) or "neutral"


def build_index(folder: Path, k: int, out: Path) -> dict:
    images = [p for p in folder.rglob("*") if p.suffix.lower() in IMG_EXTS]
    if not images:
        sys.exit(f"No images in {folder}")

    print(f"Analyzing {len(images)} images...", file=sys.stderr)
    sigs, paths = [], []
    for p in images:
        try:
            sigs.append(color_signature(p))
            paths.append(str(p))
        except Exception as e:
            print(f"  skip {p.name}: {e}", file=sys.stderr)

    raw = np.vstack(sigs)
    X = normalize_features(raw)

    k = min(k, len(X))
    km = KMeans(n_clusters=k, n_init=10, random_state=0).fit(X)

    images_meta = [
        {"path": paths[j],
         "cluster": int(km.labels_[j]),
         "features": [round(float(v), 6) for v in X[j]]}
        for j in range(len(paths))
    ]

    clusters = []
    for i in range(k):
        members = [paths[j] for j in range(len(paths)) if km.labels_[j] == i]
        c = km.cluster_centers_[i].copy()
        c[1] /= 2; c[2] /= 2
        c[0] *= 100; c[1] *= 128; c[2] *= 128; c[3] *= 100; c[4] *= 100
        clusters.append({
            "id": i,
            "label": label_centroid(c),
            "size": len(members),
            "centroid_lab_sv": [round(float(x), 1) for x in c],
            "images": members,
        })
    clusters.sort(key=lambda c: -c["size"])

    result = {"folder": str(folder), "images": images_meta, "clusters": clusters}
    out.write_text(json.dumps(result, indent=2))
    for c in clusters:
        print(f"  [{c['id']}] {c['label']:28s} {c['size']:3d} images")
    print(f"\nWrote {out}", file=sys.stderr)
    return result


def pick_pair(out: Path, cluster_id: int | None):
    if not out.exists():
        sys.exit(f"No index at {out}. Run without --pair first.")
    data = json.loads(out.read_text())
    pool = [c for c in data["clusters"] if len(c["images"]) >= 2]
    if cluster_id is not None:
        pool = [c for c in pool if c["id"] == cluster_id]
    if not pool:
        sys.exit("No cluster with >= 2 images matches.")
    cluster = random.choice(pool)
    a, b = random.sample(cluster["images"], 2)
    print(a)
    print(b)


def find_match(out: Path, query_path: Path, top_k: int = 5,
               same_cluster_only: bool = False, count: int = 1) -> list[str]:
    """Return paths of wallpapers whose color signature matches the query."""
    if count <= 0:
        return []
    if not out.exists():
        sys.exit(f"No index at {out}. Build it first by running without --match.")
    data = json.loads(out.read_text())
    if "images" not in data:
        sys.exit(
            f"Index at {out} is from an older version of this script "
            "(no per-image features). Rebuild it by running:\n"
            f"  {sys.argv[0]} <wallpaper-folder>"
        )
    images = data["images"]
    if not images:
        sys.exit("Index is empty.")

    query_abs = str(query_path.expanduser().resolve())
    # Look up existing features, else compute fresh
    hit = next((im for im in images if str(Path(im["path"]).resolve()) == query_abs), None)
    if hit is not None:
        q = np.array(hit["features"], dtype=np.float32)
        q_cluster = hit["cluster"]
    else:
        q = normalize_features(color_signature(query_path))[0]
        q_cluster = None

    feats = np.array([im["features"] for im in images], dtype=np.float32)
    dists = np.linalg.norm(feats - q, axis=1)

    # Exclude the query itself
    candidates = [(d, im) for d, im in zip(dists, images)
                  if str(Path(im["path"]).resolve()) != query_abs]
    if same_cluster_only and q_cluster is not None:
        candidates = [(d, im) for d, im in candidates if im["cluster"] == q_cluster]
    if not candidates:
        sys.exit("No candidates to match against.")

    candidates.sort(key=lambda x: x[0])
    pool_size = min(max(top_k, count), len(candidates))
    pool = candidates[:pool_size]
    if count <= len(pool):
        chosen = random.sample(pool, count)
    else:
        chosen = pool  # fewer distinct candidates than requested
    return [c[1]["path"] for c in chosen]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("folder", nargs="?", default=".")
    ap.add_argument("--clusters", type=int, default=6)
    ap.add_argument("--out", default=str(Path.home() / ".cache" / "wallpaper_clusters.json"))
    ap.add_argument("--pair", action="store_true", help="Print a random matching pair (two lines)")
    ap.add_argument("--cluster", type=int, help="Restrict --pair to this cluster id")
    ap.add_argument("--match", metavar="PATH", help="Given one wallpaper, print matching wallpapers (one per line)")
    ap.add_argument("--count", type=int, default=1, help="With --match, print N distinct matches (default 1)")
    ap.add_argument("--top-k", type=int, default=5, help="Randomize --match over the K closest (default 5)")
    ap.add_argument("--same-cluster", action="store_true", help="With --match, restrict to the query's cluster")
    args = ap.parse_args()

    out = Path(args.out).expanduser()
    out.parent.mkdir(parents=True, exist_ok=True)

    if args.match:
        for p in find_match(out, Path(args.match), args.top_k, args.same_cluster, args.count):
            print(p)
    elif args.pair:
        pick_pair(out, args.cluster)
    else:
        build_index(Path(args.folder).expanduser(), args.clusters, out)


if __name__ == "__main__":
    main()