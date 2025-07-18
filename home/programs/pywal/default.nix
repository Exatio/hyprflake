{ pkgs, lib, ... }:
let
  pywalfox-wrapper = pkgs.writeShellScriptBin "pywalfox-wrapper" ''
    ${pkgs.pywalfox-native}/bin/pywalfox start
  '';
in
{
  home.packages = with pkgs; [
    pywal
    pywalfox-native
  ];

  home.file.".config/wal/templates".recursive = true;
  home.file.".config/wal/templates".source = ./templates;


  home.file.".mozilla/native-messaging-hosts/pywalfox.json".text = lib.replaceStrings [ "<path>" ] [
    "${pywalfox-wrapper}/bin/pywalfox-wrapper"
  ] (lib.readFile "${pkgs.pywalfox-native}/lib/python3.13/site-packages/pywalfox/assets/manifest.json");

}
