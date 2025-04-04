{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.iosevka-term
  ];

  
  catppuccin.kitty.enable = true;
  programs.kitty = {
    enable = true;

    font = {
      name = "IosevkaTerm Nerd Font";
      size = 15.0;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.7";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      shell = "${pkgs.zsh}/bin/zsh";
    };

    shellIntegration.enableZshIntegration = true;
  };
}
