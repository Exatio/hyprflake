{ pkgs, ... }:
{
  imports = [
    ../wofi #temporary, until we remove rofi and wofi
  ];

  /* TODO: we wanna move to quickshell or ags the following :
    -> Wallpaper changer
    -> App Launcher
    -> Clipboard History
    -> Screenshots
    -> Waybar
    -> + maybe more
  */
  home.packages = with pkgs; [
    quickshell
    ags
  ];

}
