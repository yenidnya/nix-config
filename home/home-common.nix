{
  config,
  pkgs,
  ...
}: let
  tmux-spotify = import ./modules/tmux-spotify.nix {inherit pkgs;};
  xdgConfigHome = "${config.home.homeDirectory}/.config";
  nixConfig = "${config.home.homeDirectory}/nix-config";
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
    lldb_19
    binaryen
    luajitPackages.luacheck
    tree
  ];

  home.file = {
    "${xdgConfigHome}/nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixConfig}/home/configs/nvim";
    "${xdgConfigHome}/bin/tmux-spotify" = {
      text = tmux-spotify.tmux-spotify;
      executable = true;
    };
    "${xdgConfigHome}/.taplo.toml".source = ./configs/taplo.toml;
    "${xdgConfigHome}/starship.toml".source = ./configs/starship.toml;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  };

  programs.git = {
    enable = true;
    userName = "Batuhan Yenidunya";
    userEmail = "batuhanyndny@gmail.com";
  };

  programs.ssh.enable = true;
  programs.home-manager.enable = true;
}
