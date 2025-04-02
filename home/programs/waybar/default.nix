{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    wttrbar
    pavucontrol

    nerd-fonts.jetbrains-mono
  ];

  home.file.".config/waybar/modules".source = ./modules;

  home.file.".config/waybar/default".recursive = true;
  home.file.".config/waybar/default".source = ./default;
  
  home.file.".config/waybar/bar2".recursive = true;
  home.file.".config/waybar/bar2".source = ./bar2;
  
}
