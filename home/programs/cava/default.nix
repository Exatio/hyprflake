{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cava
  ];

  home.file.".config/cava/shaders" = {
    recursive = true;
    source = ./shaders;
  };

}
