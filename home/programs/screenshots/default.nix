{ pkgs, ... }:
{

  home.packages = with pkgs; [
    slurp
    grim
    swappy
  ];

  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=$HOME/Images/screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Noto Sans
    paint_mode=brush
    early_exit=false
    fill_shape=false
  '';

}
