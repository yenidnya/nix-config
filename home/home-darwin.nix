{ config, pkgs, ... }:

{
  imports = [
    ./home-common.nix
  ];

  home.homeDirectory = "/Users/yenidnya";

  # macOS-specific packages
  home.packages = with pkgs; [];
  
  # macOS-specific file configurations
  home.file = {};
}
