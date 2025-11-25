{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    
    settings = {

      user.name = "Exatio";
      user.email = "exatio@proton.me";

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

    };

    package = pkgs.git;
  };
  
  programs.delta.enable = true;
  programs.git-cliff.enable = true;

}
