#!/usr/bin/env bash
set -euo pipefail

bin_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
rm -f -- "$bin_dir/tinyterminal" "$app_dir/tinyterminal.desktop"
printf 'Removed TinyTerminal and its desktop launcher.\n'
printf 'Remove the TinyTerminal window rule and keybindings from your Hyprland Lua config manually.\n'
