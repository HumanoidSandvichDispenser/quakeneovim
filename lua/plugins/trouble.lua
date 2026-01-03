return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    focus = true,
    restore = true,
    follow = true,
    indent_guides = true,
    max_items = 100,
    multiline = true,
    pinned = false,
    warn_no_results = false,
    open_no_results = false,
    win = { size = { height = 0.3 } },
    window = {
      position = "bottom",
      size = { height = 0.3 },
    },
  },
  keys = {
    { "<leader>cd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
  },
}
