{
  config,
  pkgs,
  ...
}: let
  cfgHome = config.home.homeDirectory;
  xdgConfigHome = "${cfgHome}/.config";
  xdgCacheHome = "${cfgHome}/.cache";
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    shellAliases = {
      lg = "lazygit";
      vim = "nvim";
    };

    initExtra = ''
      if [[ -r "''${XDG_CACHE_HOME:-${xdgCacheHome}}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-${xdgCacheHome}}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      export LUA_CPATH=";?.dylib"
      export LUA_PATH="$LUA_PATH;${xdgConfigHome}/nvim/lua/yenidnya/?.lua"

      # Source amzn profile
      if [ -f ${xdgConfigHome}/amzn/zsh/profile ]; then
        source ${xdgConfigHome}/amzn/zsh/profile
      fi

      # Add binaries to PATH
      export PATH="$PATH:${xdgConfigHome}/bin"
      export PATH="$PATH:${cfgHome}/.cargo/bin"
      export PATH="$PATH:${cfgHome}/alejandra/target/release"

      # Source p10k
      source ~/.p10k.zsh

      # readline mode
      set -o vi
    '';
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    zsh-powerlevel10k
  ];
}
