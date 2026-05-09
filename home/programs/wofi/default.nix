{ pkgs, ... }:
{

  home.packages = with pkgs; [
    wofi
  ];

  programs.rofi = {
    enable = true;
    plugins = [pkgs.rofi-emoji];
  };

  home.file.".config/rofi/choose.rasi".source = ./rofi/choose.rasi;
  home.file.".config/rofi/screenshot.rasi".source = ./rofi/screenshot.rasi;
  home.file.".config/rofi/colors.rasi".source = ./rofi/colors.rasi;
  home.file.".config/rofi/launcher.rasi".source = ./rofi/launcher.rasi;

  home.file.".config/wofi/config-wallpaper".source = ./config-wallpaper;
  
}
