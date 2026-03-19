return {
  -- Add the melange colorscheme.
  { "savq/melange-nvim" },

  -- Configure LazyVim to load melange.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "melange",
    },
  },
}
