return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local which_key = require("which-key")
    which_key.add({
      { "<leader>b", group = "buffers" },
      { "<leader>f", group = "files" },
      { "<leader>w", group = "window" },
      { "<leader>g", group = "git" },
      { "<leader>s", group = "search" },
      { "<leader>d", group = "debug" },
    })
  end
}
