{ config, pkgs, ... }:

let
  tmux-spotify = import ./modules/tmux-spotify.nix {inherit pkgs;};
in {
  imports = [
    ./modules/zsh.nix
    ./modules/tmux.nix
    ./modules/alacritty.nix
  ];

nix = {
  package = pkgs.nix;
  settings.experimental-features = ["nix-command" "flakes"];
};



  home.username = "yenidnya";
  home.stateVersion = "24.11";

  # Cross-platform packages
  home.packages = with pkgs; [
    neovim
    openssh
    btop
    nodejs
    rustup
    neofetch
    ripgrep
  ];

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
  programs.home-manager.enable = true;
}
