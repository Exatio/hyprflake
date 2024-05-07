{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Exatio";
    userEmail = "exatio@proton.me";

    extraConfig = {
      init = {
        defaultBranch = "master";
      };
    };

    package = pkgs.git;
  };
}
