{ pkgs, ... }:
{
  home.packages = with pkgs; [ nvtopPackages.amd gnome-system-monitor ];


  catppuccin.btop.enable = true;
  programs.btop = {
    enable = true;
    package = pkgs.btop;
  };

}
