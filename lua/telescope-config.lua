#! /usr/bin/env lua
--
-- feline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")

local function fd_dir(search_dir)
    local opts = telescope_themes.get_ivy()
    opts.cwd = search_dir
    telescope_builtin.fd(opts)
end

local function search_config_dir()
    fd_dir(vim.env.NVIM)
end

local function init()
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
        }
    })
end

return {
    fd_dir = fd_dir,
    search_config_dir = search_config_dir,
    init = init
}
