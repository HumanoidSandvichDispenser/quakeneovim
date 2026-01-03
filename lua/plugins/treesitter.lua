return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "typescript",
        "vim",
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
      auto_install = true,
    })
  end,
}
