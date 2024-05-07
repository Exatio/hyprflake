{ pkgs, ... }:
{

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        # Watch for the patched fonts table in order to add more
        # https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
        # "IBMPlexMono" - will be "BlexMono Nerd Font"
        "IosevkaTerm"
      ];
    })
  ];

  programs.alacritty = {

    catppuccin.enable = true;

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
