{ pkgs, ... }:
{
  home = {

    packages = [
      pkgs.tofi
    ];

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
        font = spacemono
        background-color = #000A
      '';

      ".config/tofi/config-search".text = ''
        width = 100%
        height = 100%
        border-width = 0
        outline-width = 0
        padding-left = 5%
        padding-top = 35%
        result-spacing = 25
        num-results = 10
        font = monospace
        background-color = #000A
        prompt-text = "Search: "
      '';

      ".config/tofi/config-screenshot".text = ''
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
        prompt-text = "Type: "
      '';
    };

  };

}
