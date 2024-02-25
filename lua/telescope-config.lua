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
    if search_dir then
        opts.cwd = search_dir
    end
    telescope_builtin.fd(opts)
end

local function search_config_dir()
    fd_dir(vim.env.NVIMPATH)
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
            buffers = {
                theme = "ivy",
                sort_lastused = true,
                ignore_current_buffer = true
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
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = false,
                case_mode = "smart_case"
            },
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
            file_browser = {
                theme = "ivy",
                hijack_netrw = true
            }
        }
    })
end

telescope.load_extension("file_browser")
telescope.load_extension("fzf")

return {
    fd_dir = fd_dir,
    search_config_dir = search_config_dir,
    init = init
}
