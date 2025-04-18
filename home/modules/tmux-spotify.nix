# Define the script content in Nix format
{ pkgs, ... }:

let
  tmux-spotify = ''
    #!/usr/bin/env bash

    # Function for macOS (uses AppleScript)
    get_now_playing_macos() {
      osascript <<EOF
      set regexPattern to "^[^,-]+"
      tell application "Spotify"
          if it is running then
              if player state is playing then
                  set track_name to name of current track
                  set artist_name to artist of current track
                  set extractedWords to {}
                  try
                      set regexResult to do shell script "echo " & quoted form of track_name & " | egrep -o -m 1 " & quoted form of regexPattern
                      set extractedWords to paragraphs of regexResult
                  end try
                  set track_name to extractedWords as string
                  return "♫ " & artist_name & " - " & track_name
              end if
          end if
      end tell
EOF
    }

    # Function for Linux (uses playerctl)
    get_now_playing_linux() {
      if command -v playerctl >/dev/null && playerctl -p spotify status 2>/dev/null | grep -q "Playing"; then
        artist=$(playerctl -p spotify metadata artist)
        title=$(playerctl -p spotify metadata title)
        clean_title=$(echo "$title" | grep -o '^[^,-]*')
        echo "♫ $artist - $clean_title"
      fi
    }

    # OS detection and branching
    case "$(uname)" in
      Darwin)
        get_now_playing_macos
        ;;
      Linux)
        get_now_playing_linux
        ;;
      *)
        echo "Unsupported OS"
        ;;
    esac
  '';
  
in
{
  # Return the script content to be used in home.nix
  tmux-spotify = tmux-spotify;
}

