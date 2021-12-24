#! /usr/bin/env lua
--
-- highlight-overrides.lua
-- Copyright (C) 2021 sandvich <sandvich@sandvich-pc>
--
-- Distributed under terms of the MIT license.
--

local xresources = require("xresources")

local command = vim.api.nvim_command
local colorscheme_loaded = false

local base_colors = {
    bg0 = xresources.get("background"),
    bg0_alt = xresources.get("background-alt"),
    bg1 = xresources.get("background1"),
    bg2 = xresources.get("background2"),
    bg3 = xresources.get("background3"),
    bg4 = xresources.get("background4"),
    bg_dark = xresources.get("background-dark"),
    fg = xresources.get("foreground"),
    gray = xresources.get("color8"),
    red = xresources.get("color9"),
    green = xresources.get("color10"),
    yellow = xresources.get("color11"),
    blue = xresources.get("color12"),
    purple = xresources.get("color13"),
    aqua = xresources.get("color14"),
    orange = xresources.get("orange"),
    accent = xresources.get("accent")
}

local function get_base_colors()
    return {
        bg0 = xresources.get("background"),
        bg0_alt = xresources.get("background-alt"),
        bg1 = xresources.get("background1"),
        bg2 = xresources.get("background2"),
        bg3 = xresources.get("background3"),
        bg4 = xresources.get("background4"),
        bg_dark = xresources.get("background-dark"),
        fg = xresources.get("foreground"),
        gray = xresources.get("color8"),
        red = xresources.get("color9"),
        green = xresources.get("color10"),
        yellow = xresources.get("color11"),
        blue = xresources.get("color12"),
        purple = xresources.get("color13"),
        aqua = xresources.get("color14"),
        orange = xresources.get("orange"),
        accent = xresources.get("accent")
    }
end

local function get_highlight_info(name)
    local fg = command("synIDattr(synIDtrans(hlID('" + name + "')), 'fg')")
    local bg = command("synIDattr(synIDtrans(hlID('" + name + "')), 'bg')")
    return fg, bg
end

local function highlight_link(destination, source)
    command(string.format("hi! link %s %s", destination, source))
end

local function highlight_overrides()
    --local base_colors = get_base_colors()
    --BaseColors = base_colors

    command(string.format("hi Pmenu guibg=%s", base_colors.bg0_alt))
    command(string.format("hi PmenuSel guifg=%s guibg=%s gui=italic", base_colors.bg0, base_colors.accent))
    command("hi Comment gui=italic")

    command(string.format("hi LineNr guibg=%s", base_colors.bg0))
    command(string.format("hi CursorLineNr guibg=%s", base_colors.bg0_alt))
    command(string.format("hi CursorLine guibg=%s", base_colors.bg0_alt))

    command(string.format("hi semshiParameter guifg=%s", base_colors.blue))
    command(string.format("hi semshiParameterUnused gui=Underline guifg=%s", base_colors.blue))
    command(string.format("hi semshiSelected guibg=%s", base_colors.bg2))
    command(string.format("hi semshiImported guifg=%s", base_colors.yellow))
    command(string.format("hi semshiBuiltin guifg=%s", base_colors.yellow))
    command(string.format("hi semshiAttribute guifg=%s", base_colors.blue))
    command(string.format("hi semshiSelf guifg=%s", base_colors.red))

    command(string.format("hi GitGutterAdd guifg=%s guibg=%s", base_colors.green, base_colors.bg0))
    command(string.format("hi GitGutterChange guifg=%s guibg=%s", base_colors.blue, base_colors.bg0))
    command(string.format("hi GitGutterDelete guifg=%s guibg=%s", base_colors.red, base_colors.bg0))

    command(string.format("hi VertSplit guifg=%s guibg=%s", base_colors.bg1, base_colors.bg0))

    highlight_link("SignColumn", "Normal")

    command(string.format("hi StartifyHeader guifg=%s", base_colors.green))
    command(string.format("hi StartifySection guifg=%s", base_colors.blue))

    command(string.format("hi BufferCurrent guifg=%s guibg=%s", base_colors.fg, base_colors.bg1))
    command(string.format("hi BufferCurrentIndex guifg=%s guibg=%s", base_colors.fg, base_colors.bg1))
    command(string.format("hi BufferCurrentMod guifg=%s guibg=%s", base_colors.red, base_colors.bg1))
    command(string.format("hi BufferCurrentTarget guifg=%s guibg=%s", base_colors.fg, base_colors.bg1))
    command(string.format("hi BufferCurrentSign guifg=%s guibg=%s", base_colors.fg, base_colors.bg1))

    command(string.format("hi BufferVisible guifg=%s guibg=%s", base_colors.fg, base_colors.bg0))
    command(string.format("hi BufferVisibleIndex guifg=%s guibg=%s", base_colors.fg, base_colors.bg0))
    command(string.format("hi BufferVisibleMod guifg=%s guibg=%s gui=italic", base_colors.fg, base_colors.bg0))
    command(string.format("hi BufferVisibleTarget guifg=%s guibg=%s", base_colors.fg, base_colors.bg0))
    command(string.format("hi BufferVisibleSign guifg=%s guibg=%s", base_colors.fg, base_colors.bg0))

    command(string.format("hi BufferInactive guifg=%s guibg=%s", base_colors.bg2, base_colors.bg0))
    command(string.format("hi BufferInactiveIndex guifg=%s guibg=%s", base_colors.bg2, base_colors.bg0))
    command(string.format("hi BufferInactiveMod guifg=%s guibg=%s gui=italic", base_colors.bg2, base_colors.bg0))
    command(string.format("hi BufferInactiveTarget guifg=%s guibg=%s", base_colors.bg2, base_colors.bg0))
    command(string.format("hi BufferInactiveSign guifg=%s guibg=%s", base_colors.bg2, base_colors.bg0))

    command(string.format("hi NvimTreeFolderIcon guifg=%s", base_colors.blue))
    command(string.format("hi NvimTreeFolderName guifg=%s", base_colors.blue))
    command(string.format("hi NvimTreeOpenedFolderName guifg=%s", base_colors.blue))
    command(string.format("hi NvimTreeEmptyFolderName guifg=%s", base_colors.blue))
    command(string.format("hi NvimTreeIndentMarker guifg=%s", base_colors.bg3))
    command(string.format("hi NvimTreeRootFolder guifg=%s", base_colors.bg3))

    --[[
    command(string.format("hi NvimTreeVertSplit guifg=%s guibg=%s", base_colors.bg_dark, base_colors.bg_dark))
    command(string.format("hi NvimTreeNormal guibg=%s", base_colors.bg_dark))
    command(string.format("hi NvimTreeStatuslineNc guifg=%s guibg=%s", base_colors.bg0_alt, base_colors.bg0_alt))
    ]]

    command(string.format("hi BufferTabpages guibg=%s", base_colors.bg0))
    command(string.format("hi BufferTabpageFill guibg=%s", base_colors.bg0))

    command(string.format("hi StartifyBracket guifg=%s", base_colors.bg0))
    command(string.format("hi StartifyHeader guifg=%s", base_colors.accent))
    command(string.format("hi StartifySection guifg=%s", base_colors.bg4))
    command(string.format("hi StartifyNumber guifg=%s", base_colors.bg4))
    command(string.format("hi StartifyFile guifg=%s gui=italic", base_colors.accent))
    command(string.format("hi StartifyPath guifg=%s", base_colors.bg4))
    command(string.format("hi StartifySlash guifg=%s", base_colors.bg4))

    command(string.format("hi Accent guifg=%s", base_colors.accent))
    command(string.format("hi Gray guifg=%s", base_colors.gray))

    command(string.format("hi SignifyLineAdd guifg=%s guibg=%s", base_colors.green, base_colors.bg0))
    command(string.format("hi SignifyLineChange guifg=%s guibg=%s", base_colors.blue, base_colors.bg0))
    command(string.format("hi SignifyLineDelete guifg=%s guibg=%s", base_colors.red, base_colors.bg0))
end

function SetColorscheme(colorscheme)
    if colorscheme_loaded then
        return
    end
    colorscheme_loaded = true

    require("packer").loader(colorscheme)
end

return {
    highlight_overrides = highlight_overrides,
    GetBaseColors = get_base_colors,
    BaseColors = base_colors,
    SetColorscheme = SetColorscheme
}
