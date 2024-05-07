{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    wttrbar
    pavucontrol

    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/modules".source = ./modules;
  home.file.".config/waybar/style.css".source = ./style.css;

}
