{ pkgs, ... }:
{

  home.packages = with pkgs; [
    tofi
    wofi
  ];

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
