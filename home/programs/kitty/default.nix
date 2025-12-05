{ pkgs, ... }:
{  
  programs.kitty = {
    enable = true;

    font = {
      name = "IosevkaTerm Nerd Font";
      size = 18.0;
    };

    settings = {
      include = "colors.conf";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.8";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      shell = "${pkgs.zsh}/bin/zsh";
    };

    shellIntegration.enableZshIntegration = true;
  };
}
