{ config, pkgs, ... }:

{
  imports = [
    ./home-common.nix
  ];

  home.homeDirectory = "/home/yenidnya";

  home.packages = with pkgs; [
    xclip
    playerctl
    spotify
    toybox
  ];

  home.file = {};
  
  services.ssh-agent.enable = true;
}
