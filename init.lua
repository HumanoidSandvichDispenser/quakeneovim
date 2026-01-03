#! /usr/bin/env lua

-- set leader before loading any plugins
vim.g.mapleader = " "

local plugin_path = vim.fn.stdpath("data") .. "/lazy"

local lazypath = plugin_path .. "/lazy.nvim"

local function bootstrap(name, url, args)
    local path = plugin_path .. "/" .. name
    if not vim.loop.fs_stat(path) then
        vim.notify("Bootstrapping " .. name .. "...", vim.log.levels.INFO)
        vim.fn.system({
            "git",
            "clone",
            url,
            path,
            "--filter=blob:none",
            table.unpack(args or {}),
        })
        vim.notify("DONE", vim.log.levels.INFO)
    end
end

-- try vim.pack.add() first (available in nightly), fall back to bootstrap for stable
if vim.pack ~= nil then
    vim.pack.add({
        {
            src = "https://github.com/folke/lazy.nvim",
        },
    })
else
    bootstrap(
        "lazy.nvim",
        "https://github.com/folke/lazy.nvim.git",
        {
            "--branch=stable",
        }
    )
    vim.opt.rtp:prepend({ lazypath })
end

-- now hand off control to lazy
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- everything lazy by default
  },
})

require("keymaps")
require("configuration")
require("highlights")
