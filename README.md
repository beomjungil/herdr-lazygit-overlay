# Lazygit Overlay for Herdr

Open `lazygit` as a temporary Herdr overlay over the active pane.

Herdr's plugin pane `overlay` placement opens a zoomed overlay over the active pane and restores the previous focus and zoom when it closes. This plugin keeps the implementation small: the manifest declares a `lazygit` pane and the `open` action launches that pane with `--placement overlay --focus`.

The launcher forwards the focused pane cwd to Herdr with `--cwd`, so `lazygit` opens in the same working directory as the pane that triggered the action.

## Requirements

- Herdr `0.7.0` or newer
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
description = "open lazygit overlay"
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

The test verifies that the launcher opens the plugin pane as an overlay, forwards the focused pane working directory with `--cwd`, and does not pass `--target-pane`, which Herdr rejects for overlay panes.
