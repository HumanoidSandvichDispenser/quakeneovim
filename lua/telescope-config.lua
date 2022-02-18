#! /usr/bin/env lua
--
-- feline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

local function fd_dir(search_dirs)
    telescope_builtin.fd({
        search_dirs = search_dirs
    })
end

local function search_config_dir()
    fd_dir({ vim.env.NVIM })
end

local function init()
    telescope.setup({
        pickers = {
            find_files = {
                hidden = true
            }
        }
    })
end

return {
    fd_dir = fd_dir,
    search_config_dir = search_config_dir,
    init = init
}
