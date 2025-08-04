{ pkgs, ... }:
{
  home.packages = with pkgs; [ nvtopPackages.amd gnome-system-monitor ];

  programs.btop = {
    enable = true;
    package = pkgs.btop;
    settings = {
      color_theme = "matugen.theme";
    };
  };

}
