return {
  "lukas-reineke/indent-blankline.nvim",

  main = "ibl",

  event = "VeryLazy",

  opts = {
    -- Enable indent guides
    enabled = true,

    -- Character to use for indent guides
    char = "│",

    -- Character to use for scope indent guides
    context_char = "┊",

    -- Show the current scope
    show_current_scope = true,

    -- Show the current scope start
    show_current_scope_start = true,

    -- Show the end of the current scope
    show_current_scope_end = true,

    -- Highlight groups
    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
  },

  config = function()
    require("ibl").setup()
  end,
}
