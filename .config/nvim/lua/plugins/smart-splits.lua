return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      multiplexer_integration = "zellij",
      default_amount = 3,
      disable_multiplexer_nav_when_zoomed = true,
      move_cursor_same_row = false,
    },
    keys = {
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        mode = { "n", "t" },
        desc = "Move focus left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        mode = { "n", "t" },
        desc = "Move focus down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        mode = { "n", "t" },
        desc = "Move focus up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        mode = { "n", "t" },
        desc = "Move focus right",
      },
      {
        "<C-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
        mode = { "n", "t" },
        desc = "Move focus previous",
      },
    },
  },
}
