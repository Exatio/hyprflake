{ pkgs, ... }:
{

  home.packages = with pkgs; [
    tofi
    wofi
  ];

  programs.rofi = {
    enable = true;
    plugins = [pkgs.rofi-emoji];
  };

  home.file.".config/rofi/choose.rasi".source = ./rofi/choose.rasi;
  home.file.".config/rofi/colors.rasi".source = ./rofi/colors.rasi;
  home.file.".config/rofi/emoji-picker.rasi".source = ./rofi/emoji-picker.rasi;
  home.file.".config/rofi/launcher.rasi".source = ./rofi/launcher.rasi;

  home.file.".config/wofi/config-wallpaper".source = ./config-wallpaper;

  home.file.".config/tofi/config".text = ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 10
    font = monospace
    background-color = #000A
  '';
  
}
