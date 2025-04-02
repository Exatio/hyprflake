{ pkgs, ... }:
{

  home.packages = with pkgs; [
    nerd-fonts.iosevka-term
  ];


  catppuccin.alacritty.enable = true;
  programs.alacritty = {
    enable = true;

    settings = {

      font = {

        normal = {
          family = "IosevkaTerm Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "IosevkaTerm Nerd Font";
          style = "Bold Italic";
        };

        size = 15;

      };

      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };

      window = {
        opacity = 0.7;
      };

      window.padding = {
        x = 15;
        y = 15;
      };

    };
  };
}
