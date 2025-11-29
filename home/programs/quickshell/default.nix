{ pkgs, ... }:
{
  home = {

    /* TODO: a lot of work here ! Move everything to quickshell
      -> Wallpaper changer
      -> App Launcher
      -> Clipboard history
      -> Screenshot options
      -> Wlogout (meh, not sure)
    */

    packages = [
      pkgs.tofi
    ];

    /* still using tofi for clipboard & screenshots. can we move on ? :( */

    file = {
      ".config/tofi/config".text = ''
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

    };
    
  };

}
