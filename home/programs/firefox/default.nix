{ inputs, lib, pkgs, ... }:
let
  darkreaderManifest = {
    name = "darkreader";
    description = "custom darkreader native host for syncing with pywal";
    path = "${./darkreader}/index.js";
    type = "stdio";
  }; 
in 
{
  # you have to install the custom darkreader extension provided in the darkreader folder. 
  home.file = {
    ".mozilla/native-messaging-hosts/darkreader.json".text = builtins.toJSON
      (darkreaderManifest // { allowed_extensions = [ "darkreader@alexhulbert.com" ]; });
    ".mozilla/firefox/default/chrome/layout-oneline.css".source = ./oneline.css;
    ".mozilla/firefox/default/chrome/layout-twoline.css".source = ./twoline.css;
    ".mozilla/firefox/default/chrome/blurredfox".source = builtins.fetchGit {
      url = "https://github.com/eromatiya/blurredfox";
      rev = "6976b5460f47bd28b4dc53bd093012780e6bfed3";
    };
  };


  programs.firefox = {
    enable = true;
    profileVersion = null;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        # both mentionned these
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        
        # blurredfox mentionned these
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        "svg.context-properties.content.enabled" = true;

        # seaglass mentionned these
        "dom.w3c_touch_events.enabled" = 1;
        "widget.use-xdg-desktop-portal" = true;
        "apz.gtk.kinetic_scroll.enabled" = false;

      };
      userChrome = ''
        @import url('blurredfox/userChrome.css');
        @import url('userContent.css');
        @import url('layout-twoline.css');
      ''; 
        # @import url('layout-oneline.css');  # the seaglass creator uses this as well
    };
  };
    
}