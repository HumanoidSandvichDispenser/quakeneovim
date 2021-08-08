#! /usr/bin/env lua
--
-- highlight-overrides.lua
-- Copyright (C) 2021 sandvich <sandvich@sandvich-pc>
--
-- Distributed under terms of the MIT license.
--

local command = vim.api.nvim_command

local function get_base_colors(colorscheme)
    if colorscheme == "tokyonight" then
        return {
            bg0 = "#1a1b26",
            bg0_alt = "#1F202D",
            bg1 = "#232433",
            bg2 = "#2a2b3d",
            bg3 = "#32344a",
            bg4 = "#3b3d57",
            fg = "#a9b1d6",
            red = "#F7768E",
            yellow = "#E0AF68",
            green = "#9ECE6A",
            blue = "#7AA2F7",
            purple = "#ad8ee6",
            aqua = "#8ec07c",
            orange = "#FF9E64",
        }
    else
        return {
            bg0 = "#282828",
            bg0_alt = "#323130",
            bg1 = "#3c3836",
            bg2 = "#504945",
            bg3 = "#665C54",
            bg4 = "#7C6F64",
            fg = "#FBF1C7",
            red = "#FB4934",
            green = "#B8BB26",
            yellow = "#FABD2F",
            blue = "#83A598",
            purple = "#D3869B",
            aqua = "#8EC07C",
            orange = "#FE8019",
        }
    end
end

local function get_highlight_info(name)
    local fg = command("synIDattr(synIDtrans(hlID('" + name + "')), 'fg')")
    local bg = command("synIDattr(synIDtrans(hlID('" + name + "')), 'bg')")
    return fg, bg
end

local function highlight_link(destination, source)
    command(string.format("hi! link %s %s", destination, source))
end

function highlight_lualine()
    local colorscheme = vim.api.nvim_get_var("colors_name")
    local base_colors = get_base_colors(colorscheme)

    local theme = {
        normal = {
            a = {fg = base_colors.bg1, bg = base_colors.fg, gui = 'bold'},
            b = {fg = base_colors.fg, bg = base_colors.bg3},
            c = {fg = base_colors.fg, bg = base_colors.bg2}
        },
        insert = {
            a = {fg = base_colors.bg0, bg = base_colors.green, gui = 'bold'},
            b = {fg = base_colors.fg, bg = base_colors.bg3}
        },
        visual = {
            a = {fg = base_colors.bg0, bg = base_colors.purple, gui = 'bold'},
            b = {fg = base_colors.fg, bg = base_colors.bg3}
        },
        replace = {
            a = {fg = base_colors.bg0, bg = base_colors.red, gui = 'bold'},
            b = {fg = base_colors.fg, bg = base_colors.bg3}
        },
        inactive = {
            a = {fg = base_colors.fg, bg = base_colors.bg1, gui = 'bold'},
            b = {fg = base_colors.fg, bg = base_colors.bg1},
            c = {fg = base_colors.fg, bg = base_colors.bg2}
        }
    }

    require("lualine-config").set_colorscheme(theme)
end

function highlight_overrides()
    local colorscheme = vim.api.nvim_get_var("colors_name")
    local base_colors = get_base_colors(colorscheme)

    command(string.format("hi Pmenu guibg=%s", base_colors.bg0_alt))
    command(string.format("hi PmenuSel guifg=%s guibg=%s gui=italic", base_colors.fg, base_colors.bg1))
    command("hi Comment gui=italic")

    command(string.format("hi CursorLine guibg=%s", base_colors.bg0_alt))

    command(string.format("hi semshiParameter guifg=%s", base_colors.blue))
    command(string.format("hi semshiParameterUnused gui=Underline guifg=%s", base_colors.blue))
    command(string.format("hi semshiSelected guibg=%s", base_colors.bg2))
    command(string.format("hi semshiImported guifg=%s", base_colors.yellow))
    command(string.format("hi semshiBuiltin guifg=%s", base_colors.yellow))
    command(string.format("hi semshiAttribute guifg=%s", base_colors.blue))
    command(string.format("hi semshiSelf guifg=%s", base_colors.red))

    command(string.format("hi GitGutterAdd guifg=%s", base_colors.green))
    command(string.format("hi GitGutterChange guifg=%s", base_colors.blue))
    command(string.format("hi GitGutterDelete guifg=%s", base_colors.red))

    highlight_link("SignColumn", "Normal")

    command(string.format("hi StartifyHeader guifg=%s", base_colors.green))
    command(string.format("hi StartifySection guifg=%s", base_colors.blue))

    highlight_lualine()
end

return {
    highlight_overrides = highlight_overrides,
    highlight_lualine = highlight_lualine,
}
