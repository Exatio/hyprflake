{ pkgs, ... }:
{
  # Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
 
  # Emacs Daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
    defaultEditor = true;
    startWithUserSession = true;
    client = {
      enable = true;
      
      arguments = [
         "-c"
         "-F \"'(fullscreen . fullboth)\""
         "-a \"${pkgs.emacs}/bin/emacs -fs\"" 
      ];
    };
  };

  home.file.".emacs".source = ./emacs/.emacs;

  home.file.".emacs.snippets".source = ./emacs/.emacs.snippets;
  home.file.".emacs.snippets".recursive = true;

  home.file.".emacs.local".source = ./emacs/.emacs.local;
  home.file.".emacs.local".recursive = true;
  

  home.packages = with pkgs; [
    vim
    neovim
    vscodium
    ghidra
    silver-searcher
    github-desktop
    claude-code
    claude-monitor
  ] ++ (with pkgs.emacsPackages; [

  ]) ++ (with pkgs.jetbrains; [
    clion
    pycharm
    idea
    webstorm
  ]);


}
