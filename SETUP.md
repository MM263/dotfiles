# Productivity stack setup

## 1) Install/update apps

```bash
brew bundle --file "$HOME/dotfiles/Brewfile"
```

## 2) Apply dotfiles with GNU Stow

```bash
stow --target="$HOME" --dir="$HOME/dotfiles" .
```

## 3) Validate the repo-local checks

```bash
just check
```

`mise` is also wired for repo tasks. On first use, run `mise trust "$HOME/dotfiles/mise.toml"` and then `mise tasks run check`.

## 4) Enable Hyper key

1. Open Karabiner-Elements.
2. Go to Complex Modifications -> Add predefined rule.
3. Import `~/.config/karabiner/assets/complex_modifications/caps_lock_hyper.json`.
4. Enable "Caps Lock to Hyper when held, Escape when tapped".

## 5) Window manager + launcher

1. Start Aerospace and grant accessibility permissions.
2. In Raycast, set the hotkey to Hyper+Space.
3. Optional: set Hyper+Enter in Raycast to launch WezTerm.

Aerospace is configured in `~/.aerospace.toml` and uses Hyper (`Ctrl+Alt+Shift+Cmd`) bindings.

## 6) Launch the shell workflow

- Open WezTerm.
- WezTerm attaches to the `main` Zellij session automatically.
- Use `Ctrl+h/j/k/l` to move focus across Neovim splits and Zellij panes.
- Use `Alt+h/j/k/l` to resize Zellij panes.
- Use `Ctrl+p d` to split down, `Ctrl+p r` to split right, and `Ctrl+p n` for a new pane.
- Use `Ctrl+t n` for a new Zellij tab and `Ctrl+t h/l` to move between tabs.

## 7) First Neovim sync

```bash
nvim "+Lazy! sync" +qa
```

## 8) Machine-local shell overrides

Machine-specific path additions live in `~/.zshrc.local`, which is intentionally gitignored.

## Core shortcuts

- `Caps` (tap): Escape
- `Caps` (hold): Hyper (Ctrl+Alt+Shift+Cmd)
- `Hyper+h/j/k/l`: focus windows (Aerospace)
- `Hyper+u/i/o/p`: move windows (Aerospace)
- `Hyper+/`: cycle tiled layouts (`tiles -> horizontal -> vertical`)
- `Hyper+,`: cycle accordion layouts (`accordion -> horizontal -> vertical`)
- `Hyper+f`: toggle floating/tiling for focused window
- `Hyper+v` / `Hyper+b`: re-join focused window in layout
- `Hyper+1..9`: switch workspaces (Aerospace)
- `Hyper+m`, then `1..9`: send focused window to workspace
- `Hyper+[` / `Hyper+]`: fullscreen on/off focused window (Aerospace fullscreen)
- `Hyper+r`: reload Aerospace config
- `Ctrl+h/j/k/l`: pane navigation (Neovim <-> Zellij)
- `Alt+h/j/k/l`: Zellij pane resize
- `Ctrl+p d`: split down (Zellij)
- `Ctrl+p r`: split right (Zellij)
- `Ctrl+p n`: new pane (Zellij)
- `Ctrl+t n`: new Zellij tab
- `Ctrl+t h/l`: previous/next Zellij tab

## Notes

- Shell prompt is Starship (`.config/starship.toml`) but matches the old two-line `p10k` layout.
- Neovim is now the default editor (`EDITOR`, `VISUAL`, `GIT_EDITOR`, `SUDO_EDITOR`).
- The active terminal stack is WezTerm + Zellij + Neovim smart-splits.
- App workspace pinning in AeroSpace:
  - Telegram -> workspace `5`
  - Spotify -> workspace `6`
  - Proton Mail -> workspace `7`
  - Codex / Claude -> workspace `4`
