#! /usr/bin/env lua

local plugin_path = vim.fn.stdpath("data") .. "/lazy"

local lazypath = plugin_path .. "/lazy.nvim"
local hotpotpath = plugin_path .. "/hotpot.nvim"

table.unpack = table.unpack or unpack -- 5.1 compatibility

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
            table.unpack(args),
        })
        vim.notify("DONE", vim.log.levels.INFO)
    end
end

bootstrap(
    "lazy.nvim",
    "https://github.com/folke/lazy.nvim.git",
    {
        "--branch=stable",
    }
)

bootstrap(
    "hotpot.nvim",
    "https://github.com/rktjmp/hotpot.nvim.git",
    {
        "--branch=v0.11.0",
    }
)

bootstrap(
    "themis.nvim",
    "https://github.com/HumanoidSandvichDispenser/themis.nvim.git"
)

vim.opt.rtp:prepend({ hotpotpath, lazypath })

require("hotpot").setup({
    provide_require_fennel = true,
})

require("plugins")

require("settings")
require("keymaps")

-- temporary
--vim.cmd("source ~/.config/nvim/init-old.vim")
