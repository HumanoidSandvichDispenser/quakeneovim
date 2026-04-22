return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<Leader>fo", "<cmd>Oil<CR>" },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
    })
  end,
}
