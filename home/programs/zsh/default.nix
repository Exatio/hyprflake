{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    fd
    eza
    pfetch
  ];

  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    configFile = "~/hyprflake/home/programs/zsh/omp.config.yaml";
    enableZshIntegration = true;
  };

  programs.nix-your-shell = {
    enable = true;
    package = pkgs.nix-your-shell;
    enableZshIntegration = true;
  };

  # better cat
  programs.bat = {
    enable = true;
    package = pkgs.bat;
  };

  # Smarter cd command
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[OA";
      searchDownKey = "^[OB";
      #searchUpKey = "^[[A";
      #searchDownKey = "^[OB";
    };

    initContent = lib.mkAfter ''
      pfetch

      export ALTERNATE_EDITOR=""
      export EDITOR="${pkgs.emacs}/bin/emacsclient -t"
      export VISUAL="${pkgs.emacs}/bin/emacsclient -c -a ${pkgs.emacs}/bin/emacs"

      # Reminder to use ag when running grep
      grep() {
        echo "⚠️ Tip: consider using 'ag' (The Silver Searcher) for faster searching."
        command grep "$@"
      }
    '';

    shellAliases = {
      c = "clear && pfetch";
      cd = "z";
      pf = "pfetch";
      ls = "eza -la";
      cat = "bat";
      shutdown = "systemctl poweroff";
      fonts = "~/hyprflake/scripts/fonts.sh";
      rebuildl = "sudo nixos-rebuild switch --flake ~/hyprflake#laptop";
      rebuildd = "sudo nixos-rebuild switch --flake ~/hyprflake#desktop";
      update = "sudo nix flake update --flake ~/hyprflake";
      ncg = "nix-collect-garbage -d && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/*";
    };

  };
}

