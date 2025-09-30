{ pkgs, ... }:
{
  imports = [
    ../ide
  ];

  home.packages = with pkgs; [

    # C
    gcc
    gdb
    gf # a GDB frontend
    gnumake
    

    # Python
    python312
    
    python312Packages.pip
    python312Packages.pipx

    python312Packages.fs
    python312Packages.mip
    
    # Haskell
    ghc

    # Zig
    zig

    # Nim
    nim
    nimble
    
    # Node
    nodejs
    
    # Reverse engineering
    ghidra
    
  ];
}
