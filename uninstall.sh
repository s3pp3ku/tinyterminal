#!/usr/bin/env bash
set -euo pipefail

bin_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
rm -f -- "$bin_dir/omarchy-runner" "$app_dir/omarchy-runner.desktop"
printf 'Removed the Runner command and desktop launcher.\n'
printf 'Remove the Runner window rule and keybindings from your Hyprland Lua config manually.\n'
