return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<Leader>fo", "<cmd>Oil<CR>" },
  },
  config = function()
    require("oil").setup()
  end
}
