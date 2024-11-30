# -----------------------------------------------------
# Key bindings
# -----------------------------------------------------
{

  wayland.windowManager.hyprland.settings = {

    ## Variables

    "$mainMod" = "SUPER";

    # Apps
    "$fileManager" = "thunar";
    "$terminal" = "kitty";
    "$browser" = "mullvad-browser";

    # Scripts

    "$lock" =        "swaylock -fF";
    "$media" =       "$scripts/media.sh";
    "$volume" =      "$scripts/volume.sh";
    "$touchpad" =    "$scripts/touchpad.sh";
    "$lidSwitch" =   "$scripts/lid_switch.sh";
    "$clipboard" =   "$scripts/clipboard.sh";
    "$brightness" =  "$scripts/screen_brightness.sh";
    "$appLauncher" = "tofi-drun --drun-launch=true";
    "$screenshot" =  "$scripts/screenshot.sh";
    "$rWallpaper" =  "$scripts/random_wallpaper.sh";
    "$wallpaper" =   "$scripts/wallpaper.sh";
    "$powerMenu" =   "$scripts/power_menu.sh";
    "$emojis" =      "$scripts/emojis.sh";
    "$bar" =         "$scripts/choose_bar.sh";

    # AZERTY keyboards
    "$1" = "ampersand";
    "$2" = "eacute";
    "$3" = "quotedbl";
    "$4" = "apostrophe";
    "$5" = "parenleft";
    "$6" = "minus";
    "$7" = "egrave";
    "$8" = "underscore";
    "$9" = "ccedilla";
    "$0" = "agrave";


    bind = [
       # Main
      "$mainMod, Q, killactive"
      "$mainMod, F, fullscreen"
      "$mainMod, W, togglefloating" # "$mainMod SHIFT, Space"
      "$mainMod, J, layoutmsg, togglesplit"

      # Apps
      "$mainMod, Return, exec, $terminal"
      "$mainMod, T, exec, $fileManager"
      "$mainMod, P, exec, $browser"

      # Hyprland (TODO remove useless things here)
      "$mainMod CTRL, D, layoutmsg, removemaster"
      "$mainMod, Escape, exec, hyprctl kill"
      "$mainMod, I, layoutmsg, addmaster"
      "$mainMod, J, layoutmsg, cyclenext"
      "$mainMod, K, layoutmsg, cycleprev"
      "$mainMod, M, exec, hyprctl dispatch splitratio 0.3"
      "$mainMod SHIFT, P, pseudo," # dwindle
      "$mainMod CTRL, Return, layoutmsg, swapwithmaster"
      "$mainMod, Space, exec, $scripts/DELETE_ME_layout.sh"
      "$mainMod, G, togglegroup"
      "$mainMod, tab, workspace, m+1"
      "$mainMod SHIFT, tab, workspace, m-1"
      "ALT, tab, cyclenext,"          # change focus to another window
      "ALT SHIFT, tab, bringactivetotop,"   # bring it to the top

      # Scripts
      ## Powermenu
      "$mainMod CTRL ALT, P, exec, $powerMenu"  # CTRL, Q
      "$mainMod, L, exec, swaylock -f"

      ## Wallpapers
      "$mainMod SHIFT, W, exec, $rWallpaper"
      "$mainMod CTRL, W, exec, $wallpaper"

      ## Choose status bar
      "$mainMod CTRL, X, exec, $bar"

      ## Clipboard
      "$mainMod, V, exec, $clipboard"

      ## Emojis
      "$mainMod, semicolon, exec, $emojis"

      ## App Launcher
      "$mainMod, D, exec, $appLauncher" # $mainMod CTRL, RETURN


      # Keyboard actions
      ## Audio / Microphone
      " , xf86audioraisevolume, exec, $volume --inc"    # Volume up
      " , xf86audiolowervolume, exec, $volume --dec"    # Volume down
      " , xf86audiomute, exec, $volume --toggle"        # Mute audio
      " , xf86AudioMicMute, exec, $volume --toggle-mic" # Mute mic

      ## Keyboard backlight brightness
      " , xf86KbdBrightnessDown, exec, $kbacklight --dec" # TODO : Check my key for backlight
      " , xf86KbdBrightnessUp, exec, $kbacklight --inc"   # Supposed to be kbBrightness++

      ## Screen brightness
      " , xf86MonBrightnessUp, exec, $backlight --inc"    # Up
      " , xf86MonBrightnessDown, exec, $backlight --dec"  # Down

      ## Disable touchpad
      " CTRL SUPER, xf86TouchpadToggle, exec, $touchpad" # Why tf do i need CTRL SUPER here ??

      ## Sleep button
      " , xf86Sleep, exec, $lock"

      ## Screenshot
      " , Print, exec, $screenshot"

      ## Media control (I dont use these)
      # " , xf86AudioPlayPause, exec, $media --pause"
      # " , xf86AudioPause, exec, $media --pause"
      # " , xf86AudioPlay, exec, $media --pause"
      # " , xf86AudioNext, exec, $media --nxt"
      # " , xf86AudioPrev, exec, $media --prv"
      # " , xf86audiostop, exec, $media --stop"




      # Hyprland Workspaces, Windows focus
      ## Switch workspaces with mainMod + [0-9]
      "$mainMod, $1, workspace, 1"
      "$mainMod, $2, workspace, 2"
      "$mainMod, $3, workspace, 3"
      "$mainMod, $4, workspace, 4"
      "$mainMod, $5, workspace, 5"
      "$mainMod, $6, workspace, 6"
      "$mainMod, $7, workspace, 7"
      "$mainMod, $8, workspace, 8"
      "$mainMod, $9, workspace, 9"
      "$mainMod, $0, workspace, 10"

      ## Switch workspaces with mainMod + mouse wheel
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      ## Switch workspaces with mainMod + period/comma
      "$mainMod, period, workspace, e+1" # TODO it probably doesnt work as expected
      "$mainMod, comma, workspace, e-1"  # TODO it probably doesnt work as expected

      ## Move active window and follow to workspace
      "$mainMod SHIFT, $1, movetoworkspace, 1"
      "$mainMod SHIFT, $2, movetoworkspace, 2"
      "$mainMod SHIFT, $3, movetoworkspace, 3"
      "$mainMod SHIFT, $4, movetoworkspace, 4"
      "$mainMod SHIFT, $5, movetoworkspace, 5"
      "$mainMod SHIFT, $6, movetoworkspace, 6"
      "$mainMod SHIFT, $7, movetoworkspace, 7"
      "$mainMod SHIFT, $8, movetoworkspace, 8"
      "$mainMod SHIFT, $9, movetoworkspace, 9"
      "$mainMod SHIFT, $0, movetoworkspace, 10"

      ## Move active window to a workspace without following it
      "$mainMod CTRL, $1, movetoworkspacesilent, 1"
      "$mainMod CTRL, $2, movetoworkspacesilent, 2"
      "$mainMod CTRL, $3, movetoworkspacesilent, 3"
      "$mainMod CTRL, $4, movetoworkspacesilent, 4"
      "$mainMod CTRL, $5, movetoworkspacesilent, 5"
      "$mainMod CTRL, $6, movetoworkspacesilent, 6"
      "$mainMod CTRL, $7, movetoworkspacesilent, 7"
      "$mainMod CTRL, $8, movetoworkspacesilent, 8"
      "$mainMod CTRL, $9, movetoworkspacesilent, 9"
      "$mainMod CTRL, $0, movetoworkspacesilent, 10"

      ## Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      ## Move windows
      "$mainMod CTRL, left, movewindow, l"
      "$mainMod CTRL, right, movewindow, r"
      "$mainMod CTRL, up, movewindow, u"
      "$mainMod CTRL, down, movewindow, d"
    ];

    # Move and Resize windows using keyboard
    binde = [
      "$mainMod SHIFT, left , resizeactive,-100 0"
      "$mainMod SHIFT, right, resizeactive, 100 0"
      "$mainMod SHIFT, up   , resizeactive, 0 -100"
      "$mainMod SHIFT, down , resizeactive, 0  100"
    ];

    # Move and Resize windows using LMB and RMB
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Triggered when lid is closing/opening
    bindl= [
      ",switch:Lid Switch, exec, $lidSwitch"
    ];



  };

}
