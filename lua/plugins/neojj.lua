return {
  "NicholasZolton/neojj",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- Only one of these is needed.
    "sindrets/diffview.nvim",
    "esmuellert/codediff.nvim",

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "nvim-mini/mini.pick",
    "folke/snacks.nvim",
  },
  cmd = "Neojj",
  keys = {
    { "<leader>jj", "<cmd>Neojj<cr>", desc = "Show Neojj UI" },
  },
}
