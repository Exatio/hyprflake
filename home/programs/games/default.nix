{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher # minecraft
    pegasus-frontend # game launcher
    # emulationstation-de # game launcher
    ryubing # alternative fork for ryujinx maintained by greemdev
    lutris
    shipwright # zelda oot
    _2ship2harkinian # zelda mm 
  ] ++ [
  ];

}
