{ pkgs, ... }:
{
  imports = [
    ../ide
  ];

  home.packages = with pkgs; [

    # Python
    python312
    python312Packages.pip
    python312Packages.pipx

    # Python packages
    python312Packages.fs

    # Zig
    zig

    # Nim
    nim
    nimble



  ];
}
