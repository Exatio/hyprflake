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
  # TODO replace : must download blurredfox repo to ~/.mozilla/firefox/default/chrome/blurredfox
  # you have to install the custom darkreader extension provided in the darkreader folder. 
  home.file = {
    ".mozilla/native-messaging-hosts/darkreader.json".text = builtins.toJSON
      (darkreaderManifest // { allowed_extensions = [ "darkreader@alexhulbert.com" ]; });
  };

  programs.firefox = {
    enable = true;
    profileVersion = null;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "dom.w3c_touch_events.enabled" = 1;
        "widget.use-xdg-desktop-portal" = true;
        "apz.gtk.kinetic_scroll.enabled" = false;
      };
      userChrome = ''
        @import url('blurredfox/userChrome.css');
        @import url('userContent.css');
        @import url('layout-twoline.css');
      ''; 
        #@import url('layout-oneline.css');
    };
  };
  
  home.file = {
    ".mozilla/firefox/default/chrome/layout-oneline.css".source = ./oneline.css;
  };

  home.file = {
    ".mozilla/firefox/default/chrome/layout-twoline.css".source = ./twoline.css;
  };
    
}