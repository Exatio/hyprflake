{ pkgs, ... }:
{
  
  programs.alacritty = {
    enable = true;

    settings = {
      
      #general.import = ["colors.toml"];

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

      terminal.shell = {
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
