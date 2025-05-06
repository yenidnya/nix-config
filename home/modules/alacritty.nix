{...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      bell = {
        animation = "EaseOutExpo";
        color = "#ffffff";
        duration = 200;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;

        indexed_colors = [
          {
            index = 16;
            color = "0xdc9656";
          }
          {
            index = 17;
            color = "0xa16946";
          }
          {
            index = 18;
            color = "0x282828";
          }
          {
            index = 19;
            color = "0x383838";
          }
          {
            index = 20;
            color = "0xb8b8b8";
          }
          {
            index = 21;
            color = "0xe8e8e8";
          }
        ];

        primary = {
          background = "0x181818";
          foreground = "0xd8d8d8";
        };

        normal = {
          black = "0x181818";
          red = "0xab4642";
          green = "0xa1b56c";
          yellow = "0xf7ca88";
          blue = "0x7cafc2";
          magenta = "0xba8baf";
          cyan = "0x86c1b9";
          white = "0xd8d8d8";
        };

        bright = {
          black = "0x585858";
          red = "0xab4642";
          green = "0xa1b56c";
          yellow = "0xf7ca88";
          blue = "0x7cafc2";
          magenta = "0xba8baf";
          cyan = "0x86c1b9";
          white = "0xf8f8f8";
        };

        cursor = {
          cursor = "0xd8d8d8";
          text = "0x181818";
        };
      };

      cursor = {
        unfocused_hollow = true;
        style.shape = "Block";
      };

      font = {
        size = 15.0;

        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Bold Italic";
        };
      };

      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      selection = {
        save_to_clipboard = true;
      };

      window = {
        opacity = 0.97;
        dimensions = {
          columns = 127;
          lines = 32;
        };
        padding = {
          x = 2;
          y = 1;
        };
      };

      general = {
        live_config_reload = true;
      };
    };
  };
}
