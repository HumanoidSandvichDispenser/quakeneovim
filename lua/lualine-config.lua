#! /usr/bin/env lua
--
-- galaxyline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--
local lualine_config = {}

local highlight_overrides = require("highlight-overrides")

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
    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = colorscheme,
            component_separators = {"%#LualineSeparator#|", "%#LualineSeparator#|"},
            section_separators = {"", ""},
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = {
                filename,
                {
                    "diagnostics",
                    sources = { "coc" },
                    color_error = highlight_overrides.BaseColors.red, -- changes diagnostic's error foreground color
                    color_warn = highlight_overrides.BaseColors.orange, -- changes diagnostic's warn foreground color
                    color_info = highlight_overrides.BaseColors.blue, -- Changes diagnostic's info foreground color
                    color_hint = highlight_overrides.BaseColors.yellow, -- Changes diagnostic's info foreground color
                    symbols = { error = " ", warn = " ", info = " ", hint = " " }
                },
                {
                    "diff",
                    colored = true, -- displays diff status in color if set to true
                    -- all colors are in format #rrggbb
                    color_added = highlight_overrides.BaseColors.green, -- changes diff's added foreground color
                    color_modified = highlight_overrides.BaseColors.blue, -- changes diff's modified foreground color
                    color_removed = highlight_overrides.BaseColors.red, -- changes diff's removed foreground color
                    symbols = { added = "+", modified = "~", removed = "-" } -- changes diff symbols
                }
            },
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
        extensions = {
            "nvim-tree",
            "quickfix"
        }
    })
end

function lualine_config.init()
    --lualine_config.set_colorscheme("gruvbox")
    require("lua.highlight-overrides").highlight_lualine()
end

return lualine_config
