{ config, pkgs, lib, ... }:

let 
  tmux-spotify = import ./modules/tmux-spotify.nix {inherit pkgs;};
in 
{

  imports = [
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
  ];

  nixpkgs.config.allowUnfree =true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yenidnya";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/yenidnya" else "/home/yenidnya";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neovim
    xclip
    openssh
    gcc
    discord
    btop
    nodejs
    rustup
    spotify
    playerctl
    busybox
    neofetch
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "${config.home.homeDirectory}/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home/configs/nvim";
    "${config.home.homeDirectory}/.config/bin/tmux-spotify" = {
        text = tmux-spotify.tmux-spotify;
        executable = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
      enable = true;
      userName = "Batuhan Yenidunya";
      userEmail = "batuhanyndny@gmail.com";
  };
  programs.ssh.enable = true; 
  services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
