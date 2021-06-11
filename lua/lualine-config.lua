#! /usr/bin/env lua
--
-- galaxyline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--
local lualine_config = {}

local function modified()
    local buf = vim.api.nvim_get_current_buf()
    local isModified = vim.api.nvim_buf_get_option(buf, "modified")
    return isModified and " ⚫" or ""
end

local function readonly()
    local buf = vim.api.nvim_get_current_buf()
    local isReadonly = vim.api.nvim_buf_get_option(buf, "readonly")
    return isReadonly and "  " or ""
end

local function filename()
    local file = vim.fn.expand("%:t")
    if (file == "") then
        file = "[untitled]"
    end

    return file .. readonly() .. modified()
end

function lualine_config.set_colorscheme(colorscheme)
    print(string.format("setting colorscheme to %s", colorscheme))
    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = colorscheme,
            component_separators = {"|", "|"},
            section_separators = {"", ""},
            disabled_filetypes = {}
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = { filename },
            lualine_x = {"encoding", "fileformat", "filetype"},
            lualine_y = {"progress"},
            lualine_z = {"location"}
        },
        inactive_sections = {
           lualine_a = {},
           lualine_b = {},
           lualine_c = {"filename"},
           lualine_x = {"location"},
           lualine_y = {},
           lualine_z = {}
        },
        tabline = {},
        extensions = {}
    })
end

function lualine_config.init()
    lualine_config.set_colorscheme("gruvbox")
end

return lualine_config
