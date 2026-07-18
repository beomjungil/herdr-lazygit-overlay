# Lazygit Overlay for Herdr

Open `lazygit` as a session-modal Herdr popup window over the active pane.

Herdr `0.7.4` added session-modal popup floating terminal panes (`placement = "popup"`): the popup floats over the tiled layout without changing it and closes when the command exits. This plugin keeps the implementation small: the manifest declares a `lazygit` popup pane sized `90%` x `85%` of the terminal, and the `open` action launches that pane with `--placement popup --width 90% --height 85% --focus`.

The launcher forwards the focused pane cwd to Herdr with `--cwd`, so `lazygit` opens in the same working directory as the pane that triggered the action.

## Requirements

- Herdr `0.7.4` or newer
- `lazygit` on `PATH`
- Access to this private GitHub repository

## Install

```bash
herdr plugin install beomjungil/herdr-lazygit-overlay --ref main
herdr server reload-config
```

If private repository installation is not available in your Herdr/GitHub setup, clone and link it locally:

```bash
git clone https://github.com/beomjungil/herdr-lazygit-overlay.git
herdr plugin link ./herdr-lazygit-overlay
herdr server reload-config
```

## Recommended Keybinding

Add this to `~/.config/herdr/config.toml`:

```toml
[[keys.command]]
key = "prefix+ctrl+g"
type = "shell"
command = "herdr plugin action invoke open --plugin beomjungil.lazygit-overlay"
description = "open lazygit popup"
```

Then reload Herdr config:

```bash
herdr server reload-config
```

## Manual Run

```bash
herdr plugin action invoke open --plugin beomjungil.lazygit-overlay
```

## Test

```bash
bash tests/open_script_test.sh
```

The test verifies that the launcher opens the plugin pane as a popup with explicit `--width`/`--height`, forwards the focused pane working directory with `--cwd`, and does not pass `--target-pane` or `--direction`, which Herdr rejects for popup panes.
