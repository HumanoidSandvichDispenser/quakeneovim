return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    }
  },
  cmd = "Telescope",
  keys = {
    { "<Leader><Leader>", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<Leader>ff", "<cmd>Telescope git_files<CR>", desc = "Find files (git)" },
    { "<Leader>fF", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<M-x>", "<cmd>Telescope<CR>", desc = "Telescope" },
    { "<Leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")

    telescope.setup({
      pickers = {
        find_files = {
          hidden = true,
          theme = "ivy"
        },
        oldfiles = {
          hidden = true,
          theme = "ivy"
        },
        buffers = {
          theme = "ivy",
          sort_lastused = true,
          ignore_current_buffer = true
        },
        current_buffer_fuzzy_find = {
          hidden = true,
          theme = "ivy"
        },
        default = {
          hidden = true,
          theme = "ivy"
        },
      },
      defaults = {
        prompt_prefix = "] ",
        file_ignore_patterns = {
          "node_modules",
          "\\.git/"
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = false,
          case_mode = "smart_case"
        },
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        file_browser = {
          theme = "ivy",
          hijack_netrw = true
        }
      }
    })
  end
}
