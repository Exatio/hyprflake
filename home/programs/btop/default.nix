{ pkgs, ... }:
{
  home.packages = with pkgs; [ nvtopPackages.amd gnome.gnome-system-monitor ];

  programs.btop = {
    enable = true;
    package = pkgs.btop;
    catppuccin.enable = true;
  };

}
