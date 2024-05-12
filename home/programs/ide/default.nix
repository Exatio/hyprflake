{ pkgs, ... }:
{
  # Emacs Daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
    defaultEditor = true;
    startWithUserSession = true;
    client = {
      enable = true;
      arguments = [ "-F" ];
    };
  };

  home.file.".emacs".source = ./emacs/.emacs;

  home.file.".emacs.rc".source = ./emacs/.emacs.rc;
  home.file.".emacs.rc".recursive = true;

  home.file.".emacs.snippets".source = ./emacs/.emacs.snippets;
  home.file.".emacs.snippets".recursive = true;
  

  home.packages = with pkgs; [
    vim
    neovim
    vscodium
  ] ++ (with pkgs.emacsPackages; [

  ]);


}
