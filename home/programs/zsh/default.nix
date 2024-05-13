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

      export ALTERNATE_EDITOR=""
      export EDITOR="${pkgs.emacs}/bin/emacsclient -t"                                    # $EDITOR opens in terminal
      export VISUAL="${pkgs.emacs}/bin/emacsclient -c -a ${pkgs.emacs}/bin/emacs"         # $VISUAL opens in GUI mode
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
      rebuild = "sudo nixos-rebuild switch --flake ~/hyprflake#nixos-laptop";
      update = "sudo nix flake update ~/hyprflake";
      ncg = "nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/*";
    };

  };
}

