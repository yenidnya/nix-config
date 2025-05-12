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
