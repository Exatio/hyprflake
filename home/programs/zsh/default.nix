{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    eza
    pfetch
  ];

  programs.starship = {
    enable = true;
    package = pkgs.starship;
    catppuccin.enable = true;
  };

  programs.bat = {
    enable = true;
    package = pkgs.bat;
    catppuccin.enable = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      #searchUpKey = "^[[A";
      #searchDownKey = "^[OB";
    };

    initExtraFirst = ''
      pfetch
      cat ~/.cache/wal/sequences
    '';

    initExtra = ''
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      eval "$(starship init zsh)"
    '';



    shellAliases = {
      c = "clear && pfetch";
      pf = "pfetch";
      ls = "eza -la";
      cat = "bat";
      shutdown = "systemctl poweroff";
      fonts = "~/hyprflake/scripts/fonts.sh";
      rebuild = "sudo nixos-rebuild switch --flake /home/exatio/hyprflake#nixos-laptop";
      update = "sudo nix flake update /home/exatio/hyprflake#nixos-laptop";
      ncg = "nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/*";
    };

  };
}
