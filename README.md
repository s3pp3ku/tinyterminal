# TinyTerminal

TinyTerminal is a one-row command terminal for Omarchy, tucked into the lower-right corner and ready for pasted commands. It runs in Foot and stays available across workspaces when pinned. Use `Ctrl+Shift+Down` to focus it and `Ctrl+Shift+Up` to return to your tiled windows.

Related projects exist. [HyprRun](https://github.com/fajremvp/HyprRun) is a minimal Hyprland app launcher, and Omarchy's [Command Bar](https://github.com/Saikomantisu/omarchy-commandbar) is a Quickshell overlay for launching apps and commands. TinyTerminal focuses on a persistent, real shell prompt in a one-line terminal for pasting and running commands. I did not find another project with that exact combination in the Omarchy plugin directory when checked in October 2026.

## Install the terminal

Requirements: Omarchy/Hyprland, Foot, and Zsh. On Arch, install missing dependencies with `sudo pacman -S foot zsh`.

```sh
git clone https://github.com/s3pp3ku/tinyterminal.git
cd tinyterminal
./install.sh
```

The installer copies the launcher to `~/.local/bin` and its desktop entry to `~/.local/share/applications`. It does not edit Hyprland configuration or install packages. Ensure `~/.local/bin` is on your `PATH`.

## Optional Hyprland behavior

Add this window rule near the bottom of `~/.config/hypr/hyprland.lua` to make TinyTerminal a compact floating window pinned to every workspace, placed in the lower-right, and ignored by mouse-hover focus:

```lua
hl.window_rule({
  name = "tinyterminal",
  match = { class = "org.omarchy.tinyterminal" },
  float = true,
  pin = true,
  no_follow_mouse = true,
  size = { 580, 48 },
  move = { "monitor_w-window_w-20", "monitor_h-window_h-20" }
})
```

Add these bindings to `~/.config/hypr/bindings.lua`:

```lua
hl.unbind("SUPER + SHIFT + RETURN") -- Omarchy binds this to Browser by default.
o.bind("SUPER + SHIFT + RETURN", "Quick command terminal", {
  launch = "tinyterminal"
})
o.bind("SUPER + SHIFT + I", "Browser", { omarchy = "browser" })
o.bind("CTRL + SHIFT + DOWN", "Focus TinyTerminal",
  hl.dsp.focus({ window = "class:org.omarchy.tinyterminal" }))
o.bind("CTRL + SHIFT + UP", "Return to main tiled windows", function()
  local active = hl.get_active_window()
  if active and active.class == "org.omarchy.tinyterminal" then
    hl.dispatch(hl.dsp.window.cycle_next({ tiled = true, floating = false }))
  else
    hl.dispatch(hl.dsp.focus({ direction = "u" }))
  end
end)
```

Hyprland Lua APIs can change with Omarchy releases. After editing, validate with:

```sh
hyprctl reload
hyprctl configerrors
```

You can launch TinyTerminal from `Super+Space` by typing **TinyTerminal**. To use the shorter `runner` command in Zsh, add `alias runner='tinyterminal >/dev/null 2>&1 &!'` to `~/.zshrc` and open a new shell.

### This machine's shortcuts

- `Super+Shift+Enter`: open TinyTerminal. This replaces Omarchy's default Browser shortcut.
- `Super+Shift+I`: open the default Internet browser.

## Optional Omarchy bar button

This repository also has a small Quickshell bar-widget plugin. Install it after installing the terminal, then enable **TinyTerminal** in the bar:

```sh
omarchy plugin add https://github.com/s3pp3ku/tinyterminal.git --enable
```

The button shows `%` and runs `tinyterminal` when clicked. The widget does not install software, use elevated privileges, or change Hyprland bindings. Validate the plugin before sharing it:

```sh
omarchy plugin validate .
```

## Remove

Run `./uninstall.sh` from this repository to remove the launcher and desktop entry. Remove the window rule and bindings manually from your Hyprland Lua files. Remove the optional bar button with:

```sh
omarchy plugin remove io.github.s3pp3ku.tinyterminal
```

## License

MIT. TinyTerminal is an independent community project and is not affiliated with or endorsed by Omarchy, Basecamp, 37signals, or DHH.
