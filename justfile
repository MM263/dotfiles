set shell := ["zsh", "-lc"]

check:
  zsh -n .zshrc
  if command -v shellcheck >/dev/null 2>&1; then shellcheck .zshrc; else echo "shellcheck not installed; skipping"; fi
  if command -v stylua >/dev/null 2>&1; then stylua --check .config/nvim/lua .config/wezterm/wezterm.lua; else echo "stylua not installed; skipping"; fi
  if command -v taplo >/dev/null 2>&1; then taplo fmt --check .aerospace.toml .config/starship.toml; else echo "taplo not installed; skipping"; fi
  stow --simulate --target="$HOME" --dir="$PWD" .

fmt:
  if command -v stylua >/dev/null 2>&1; then stylua .config/nvim/lua .config/wezterm/wezterm.lua; else echo "stylua not installed; skipping"; fi
  if command -v taplo >/dev/null 2>&1; then taplo fmt .aerospace.toml .config/starship.toml; else echo "taplo not installed; skipping"; fi
