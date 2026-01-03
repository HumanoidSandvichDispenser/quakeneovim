--
-- configuration.lua
--

-- ============================================================================
-- DISPLAY & UI OPTIONS
-- ============================================================================

-- Shows cursor position (line, column) in status line
vim.opt.ruler = true

-- Shows line numbers in the gutter
vim.opt.number = true

-- Shows partial commands in status line while typing
vim.opt.showcmd = true

-- Hides mode display (handled by other plugins)
vim.opt.showmode = false

-- Enables true color support in terminal
vim.opt.termguicolors = true

-- Highlights current line
vim.opt.cursorline = true

-- Wraps lines at word boundaries
vim.opt.linebreak = true

-- Preserves indentation when wrapping lines
vim.opt.breakindent = true

-- Hides tab line (set to 0)
vim.opt.showtabline = 0

-- Always shows status line (set to 2)
vim.opt.laststatus = 2

vim.opt.title = true

vim.opt.titlestring = "%(%{expand(\"%:~:.:h\")}%)/%t - Neovim"

-- ============================================================================
-- TEXT EDITING & INDENTATION
-- ============================================================================

-- Uses spaces instead of tabs
vim.opt.expandtab = true

-- Sets tab width to 4 spaces
vim.opt.tabstop = 4

-- Sets indentation width to 4 spaces
vim.opt.shiftwidth = 4

-- Case-sensitive search when uppercase present
vim.opt.smartcase = true

-- Case-insensitive search by default
vim.opt.ignorecase = true

-- ============================================================================
-- BEHAVIOR & NAVIGATION
-- ============================================================================

-- Key mapping timeout (1500ms)
vim.opt.timeoutlen = 1500

-- Allows switching buffers without saving
vim.opt.hidden = true

-- Keeps 3 lines visible when scrolling
vim.opt.scrolloff = 3

-- Auto-reloads files when changed externally
vim.opt.autoread = true

-- Enables mouse support ("a" = all modes)
vim.opt.mouse = "a"

-- ============================================================================
-- VISUAL CUSTOMIZATION
-- ============================================================================

-- Sets GUI font to "Iosevka Sandvich:h12"
vim.opt.guifont = "Iosevka Sandvich:h12"

-- Shows invisible characters
vim.opt.list = true

-- Customizes tab display
vim.opt.listchars = {
  tab = "▏ ",
}

-- Custom cursor shapes for different modes
vim.opt.guicursor = "n-v:block,i-ci-ve-c:ver25-Cursor"

-- Customizes vertical split and end-of-buffer characters
vim.opt.fillchars = {
  eob = "*",
  stlnc = "─",
  vert = "┃",
}

-- ============================================================================
-- SYSTEM INTEGRATION
-- ============================================================================

-- Sets file encoding to UTF-8
vim.opt.encoding = "utf-8"

-- Enables system clipboard integration
vim.opt.clipboard:append("unnamedplus")

-- ============================================================================
-- AUTO COMMANDS
-- ============================================================================

-- Automatically reloads files when Neovim gains focus
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  command = "checktime",
})
