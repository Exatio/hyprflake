{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Exatio";
    userEmail = "exatio@proton.me";

    aliases = {
      tree = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };

    extraConfig = {
      
      init = {
        defaultBranch = "master";
      };

      merge = {
        conflictStyle = "diff3";
      };

    };

    delta.enable = true;

    package = pkgs.git;
  };

  programs.git-cliff.enable = true;

}
