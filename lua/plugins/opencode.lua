return {
  "sudo-tee/opencode.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    -- optional helpers used by the plugin; present in this config if available
    "saghen/blink.cmp",
    "folke/snacks.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { 'markdown', 'opencode_output' },
      },
      ft = { 'markdown', 'opencode_output' },
    },
  },

  -- map <C-\> to toggle/open Opencode
  keys = {
    {
      "<C-\\>",
      function() require("opencode.api").toggle() end,
      mode = { "n", "v", "i" },
      desc = "Toggle Opencode",
    },
  },

  -- Use explicit config to call the plugin setup API with sensible defaults
  config = function()
    require('opencode').setup({
      default_global_keymaps = true, -- enable the plugin's default keymaps (<leader>o/...)
    })
  end,
}
