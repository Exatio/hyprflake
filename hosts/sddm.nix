{ pkgs, ... }: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      ScreenWidth = "2560";
      ScreenHeight = "1440";
      FontSize = "15";
      # AccentColor = "#746385";
      # FormPosition = "right";
    };

    # values : astronaut black_hole cyberpunk hyprland_kath jake_the_dog 
    # japanese_aesthetic pixel_sakura pixel_sakura_static post-apocalyptic_hacker purple_leaves
    embeddedTheme = "purple_leaves";
  };

  sddm-chili = pkgs.sddm-chili-theme.override {
    themeConfig = {
      ScreenWidth = 2560;
      ScreenHeight = 1440;
    };
  };
in {
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = [sddm-astronaut];
    theme = "sddm-astronaut-theme"; 

   /* extraPackages = [sddm-chili];
    theme = "chili";*/
  };

  environment.systemPackages = [
    sddm-astronaut
  ];
  
}
