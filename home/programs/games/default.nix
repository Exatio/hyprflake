{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher # minecraft
    pegasus-frontend # game launcher
    # emulationstation-de # game launcher
    # ryujinx
    lutris
  ];


}
