#! /usr/bin/env lua
--
-- alpha-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local utils = require("utils")
local colorscheme = require("highlight-overrides").BaseColors

local header_text = [[
              ▓▓▓▓  ▓▓▓▓    
            ▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ███████   █████   ██████  ██    ██ ██ ██████████
          ▓▓▓▓██  ████  ▓▓  ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
          ▓▓▓▓▓▓▓▓▓▓▓▓▓▓     ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒     ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓       ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
        ░░░░░░░░░░░░░░      ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
]]

local header = {
    type = "text",
    val = utils.split(header_text, "\n"),
    opts = {
        hl = "StartifyHeader",
        position = "center",
        width = 72,
        -- wrap = "overflow";
    }
}

local function icon(fn)
    if pcall(require, 'nvim-web-devicons') then
        local nvim_web_devicons = require('nvim-web-devicons')
        local ext = fn:match("^.+(%..+)$")
        if ext then
            ext = ext:sub(2)
        end
        return nvim_web_devicons.get_icon(fn, ext, { default = true })
    else
        return '', nil
    end
end

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = ""..sc.." ",
        cursor = 0,
        width = 72,
        align_shortcut = "left",
        hl = { { "StartifyPath", 0, 1 } },
        --hl_shortcut = "StartifyNumber",
        shrink_margin = false,
    }
    if keybind then
        opts.keymap = {"n", sc_, keybind, {noremap = false, silent = true}}
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts
    }
end

local function mru(start, cwd)
    vim.cmd("rshada")
    local oldfiles = {}
    for _,v in pairs(vim.v.oldfiles) do
        if #oldfiles == 8 then break end
        local cwd_cond
        if not cwd then
            cwd_cond = true
        else
            cwd_cond = vim.fn.filereadable(v) == 1
        end
        if (vim.fn.filereadable(v) == 1) and cwd_cond then
            oldfiles[#oldfiles+1] = v
        end
    end

    local tbl = {}
    for i, fn in pairs(oldfiles) do
        local ico, hl = icon(fn)
        local short_fn
        if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
        else
            short_fn = vim.fn.fnamemodify(fn, ":~")
        end
        local file_button = button(tostring(i + start - 1), ico .. "  " .. short_fn , ":e " .. fn .. " <CR>")
        --if hl then file_button.opts.hl = { { hl, 0, 1 } } end -- starts at val and not shortcut
        tbl[#tbl+1] = file_button
    end
    return {
        type = "group",
        val = tbl,
        opts = {
        }
    }
end

--[[
\	{ 'v': '$DOTFILES/.config/nvim/init.vim' },
\	{ 'z': '$DOTFILES/.zshrc' },
\	{ 's': '$HOME/.config/sxhkd/sxhkdrc' },
\	{ 'b': '$HOME/.config/bspwm/bspwmrc' },
\	{ 'd': '$HOME/.config/dunst/dunstrc' },
\	{ 'f': '$HOME/.config/vifm/vifmrc' },
\   { 'x': '$HOME/.Xresources' },
--]]

local function bookmarks()
    local bookmarks_table = {
        { "v", "  neovim config", ":e $DOTFILES/.config/nvim/init.vim" },
        { "z", "  zshrc", ":e $DOTFILES/.zshrc" },
        { "b", "  bspwm config", ":e $DOTFILES/.config/bspwm/bspwmrc" },
        { "s", "  sxhkd config", ":e $DOTFILES/.config/sxhkd/sxhkdrc" },
        { "x", "  xresources", ":e $DOTFILES/.Xresources" },
        { "f", "  search files", ":Files" },
        { "r", "﬍  ripgrep", ":Rg" },
    }

    local bookmarks_buttons = { }

    -- bookmark[1] = key to press
    -- bookmark[2] = title of bookmark
    -- bookmark[3] = path to bookmark
    for _, bookmark in pairs(bookmarks_table) do
        local file_button = button(bookmark[1], bookmark[2], bookmark[3] .. " <CR>")
        --file_button.opts.hl = { { "StartifyPath", 0, 2 } }
        bookmarks_buttons[#bookmarks_buttons + 1] = file_button
    end

    return {
        type = "group",
        val = bookmarks_buttons,
        opts = { }
    }
end

local section = {
    header = header,
}

local opts = {
    layout = {
        { type = "padding", val = 2 },
        section.header,
        { type = "padding", val = 2 },
        button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        { type = "padding", val = 1 },
        {
            type = "text",
            val = "  Bookmarks",
            opts = {
                hl = "StartifySection",
                position = "center",
                width = 4,
            }
        },
        { type = "padding", val = 1 },
        bookmarks(),
        { type = "padding", val = 1 },
        {
            type = "text",
            val = "  Recent Files",
            opts = {
                hl = "StartifySection",
                position = "center",
                width = 80
            }
        },
        { type = "padding", val = 1 },
        mru(0),
        { type = "padding", val = 1 },
        --button("<Esc>", "  Close", ":BD <CR>"),
        button("q", "  Quit", ":q <CR>"),
    },
    opts = {
        margin = 3,
    },
}

return {
    button = button,
    header = header,
    scection = section,
    opts = opts,
}
