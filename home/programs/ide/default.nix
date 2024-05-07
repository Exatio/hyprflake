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

  home.packages = with pkgs; [
    vim
    neovim
  ] ++ (with pkgs.emacsPackages; [

  ]);


}
