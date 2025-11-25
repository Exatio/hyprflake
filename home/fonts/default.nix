{ pkgs, ... }:
{
  home.packages = with pkgs; [

    fira

    source-code-pro

    noto-fonts-color-emoji

    cantarell-fonts

    font-awesome_4
    font-awesome_5

    # Watch for the patched fonts table in order to add more
    # https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
    # "IBMPlexMono" - will be "BlexMono Nerd Font"
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.noto
  ];

}
