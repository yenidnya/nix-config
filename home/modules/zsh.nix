{config, ...}: let
  cfgHome = config.home.homeDirectory;
  xdgConfigHome = "${cfgHome}/.config";
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;

    shellAliases = {
      lg = "lazygit";
      vim = "nvim";
    };

    initExtraFirst = ''
      set -o vi

      export LUA_CPATH=";?.dylib"
      export LUA_PATH="$LUA_PATH;${xdgConfigHome}/nvim/lua/yenidnya/?.lua"

      export PATH="$PATH:${xdgConfigHome}/bin"
      export PATH="$PATH:${cfgHome}/.cargo/bin"
      export PATH="$PATH:${cfgHome}/alejandra/target/release"


      export GSTREAMER_PATH="/Library/Frameworks/GStreamer.framework/Versions/1.0"
      export GST_PLUGIN_SYSTEM_PATH="$GSTREAMER_PATH/include/gstreamer-1.0"

      # Add to compiler search paths
      export PKG_CONFIG_PATH="$GSTREAMER_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"

      ZLIB_LIBRARY_PATH=$(nix eval --raw nixpkgs#zlib.out)
    '';

    initExtra = ''
      eval "$(starship init zsh)"

      # Source amzn profile
      if [ -f ${xdgConfigHome}/amzn/zsh/profile ]; then
          source ${xdgConfigHome}/amzn/zsh/profile
      fi
    '';
  };

  programs.starship = {
    enable = true;
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
}
