{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    
    settings = {

      user.name = "Exatio";
      user.email = "exatio@proton.me";

      alias = {
        tree = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      };

      init = {
        defaultBranch = "master";
      };
      
      merge = {
        conflictStyle = "zdiff3";
      };
    };

    package = pkgs.git;
  };
  
  # Syntax highlighting for git (diff, grep, blame)
  programs.delta = {
    enable = true;
    package = pkgs.delta;
    options = {
      navigate = true;
      dark = true;
      line-numbers = true;
    };
    enableGitIntegration = true;
  };

  # Git Changelog Generator
  programs.git-cliff = {
    enable = true;
    package = pkgs.git-cliff;
    settings = {
      # maybe if I use it someday
    };
  };

}
