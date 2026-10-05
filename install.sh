#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"

if ! command -v foot >/dev/null || ! command -v zsh >/dev/null; then
  printf 'TinyTerminal requires Foot and Zsh. Install them with your distribution package manager.\n' >&2
  exit 1
fi

install -Dm755 "$root/tinyterminal" "$bin_dir/tinyterminal"
install -d "$app_dir"
sed "s|@TINYTERMINAL_EXEC@|$bin_dir/tinyterminal|" "$root/tinyterminal.desktop" \
  > "$app_dir/tinyterminal.desktop"
chmod 644 "$app_dir/tinyterminal.desktop"
rm -f -- "$bin_dir/omarchy-runner" "$app_dir/omarchy-runner.desktop"
printf 'Installed TinyTerminal to %s/tinyterminal\n' "$bin_dir"
printf 'Desktop launcher: %s/tinyterminal.desktop\n' "$app_dir"
printf '\nAdd %s to PATH if it is not already there.\n' "$bin_dir"
printf 'For Hyprland pinning, focus keys, and bottom-right placement, see README.md.\n'
