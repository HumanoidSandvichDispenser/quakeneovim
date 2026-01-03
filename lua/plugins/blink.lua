return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "neovim/nvim-lspconfig", "fang2hou/blink-copilot" },
  opts = {
    keymap = {
      preset = "enter",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = false,
      ["<C-p>"] = { "select_prev", "show" },
      ["<C-n>"] = { "select_next", "show" },
      ["<Tab>"] = { 'select_next', 'snippet_forward', 'fallback'},
      ["<S-Tab>"] = { 'select_prev', 'snippet_backward', 'fallback'},
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      documentation = {
        auto_show = true,
      }
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "cmdline", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        cmdline = {
          name = "cmdline",
          module = "blink.cmp.sources.cmdline",
        },
      },
    },
    appearance = {
      kind_icons = {
        Copilot = "",
      },
    },
  },
}
