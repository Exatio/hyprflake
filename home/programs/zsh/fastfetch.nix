{ pkgs, lib, ... }:
{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {

      logo = {
        type = "kitty-direct";
        source = "~/hyprflake/assets/apps/fastfetch/*.png";
        padding = {
          top = 1;
          left = 2;
        };
      };

      display = {
        separator = "  ";
        color = {
          # title = "yellow";
        };
      };

      modules = [
        "break"
        "title"
        {
          type = "os";
          key = "os    ";
        }
        {
          type = "wm";
          key = "de    ";
        }
        {
          type = "datetime";
          key = "now   ";
          format = "{14}h{18}, {23}/{4}/{1}";
        }
        {
          type = "shell";
          key = "shell ";
        }
        {
          type = "uptime";
          format = "{2}h {3}m";
          key = "uptime";
        }
        {
          type = "memory";
          key = "memory";
        }
      ];

    };
  };
}