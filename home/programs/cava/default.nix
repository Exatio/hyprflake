{ pkgs, ... }:
{
  programs.cava = {
    enable = true;

    package = (pkgs.cava.override { withSDL2 = true; }).overrideAttrs (old: rec {
      src = pkgs.fetchFromGitHub {
        owner = "karlstav";
        repo = "cava";
        rev = "1b6c8c6f2eb49d4d547821456f8ad85eea812d64";  # replace with the commit you want
        sha256 = "sha256-5jyOKDpItgvZcM3RvbZyag1C9IatTaCeSlQrpyLQsPU=";  # replace with the correct hash
      };
    });

    settings = {
        # -- IF I WANNA PLAY WITH SHADERS --
        #"output" = {
        #  "method" = "'sdl_glsl'";
        # "fragment_shader" = "'northern_lights.frag'";
        #  "vertex_shader" = "'pass_through.vert'";
        #};
        
        "output" = {
          "method"="sdl";
          "channels"="mono";
        };

        "color" = {
          "theme" = "'custom'";
        };
    };
  };

  home.file.".config/cava/shaders" = {
    recursive = true;
    source = ./shaders;
  };

}
