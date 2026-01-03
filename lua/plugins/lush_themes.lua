return {
  "lush-themes",
  dir = "~/git/lush-themes",
  dependencies = { "rktjmp/lush.nvim" },
  lazy = false,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd("source /var/tmp/colorscheme.vim")
  end,
}
