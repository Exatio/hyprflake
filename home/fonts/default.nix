{ pkgs, ... }:
{
  home.packages = with pkgs; [

    fira

    source-code-pro

    noto-fonts-emoji

    cantarell-fonts

    font-awesome_4
    font-awesome_5

    (pkgs.nerdfonts.override {
      fonts = [
        # Watch for the patched fonts table in order to add more
        # https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
        # "IBMPlexMono" - will be "BlexMono Nerd Font"
        "Hack"
      ];
    })


  ];

}
