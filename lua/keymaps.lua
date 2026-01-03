--
-- keymaps.lua
--

vim.keymap.set("n", "Y", "yy")
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set({ "n", "v", "o" }, ";", ":", { silent = true, noremap = true })

-- insert mode keymaps
vim.keymap.set("i", "<C-a>", "<C-o>^")
vim.keymap.set("i", "<C-e>", "<C-o>$")
vim.keymap.set("i", "<C-n>", "<Down>")
vim.keymap.set("i", "<C-p>", "<Up>")
vim.keymap.set("i", "<C-h>", "<C-w>")
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-k>", "<C-o>dd")
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set({ "n", "i" }, "<C-s>", "<Cmd>w<CR>")

-- window keymaps
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wq", "<C-w>q")

-- buffer keymaps
vim.keymap.set("n", "<leader>bd", "<Cmd>bd<CR>")
