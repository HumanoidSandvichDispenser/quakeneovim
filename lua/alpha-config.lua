#! /usr/bin/env lua
--
-- alpha-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local alpha_config = {}

local alpha = require("alpha")
local menu = require("alpha-menu")
local utils = require("utils")

local header_text = [[
      ▓▓▓▓  ▓▓▓▓    
    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ███████   █████   ██████  ██    ██ ██ ██████████
  ▓▓▓▓██  ████  ▓▓  ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓     ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒     ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
▓▓▓▓▓▓▓▓▓▓▓▓▓▓       ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
░░░░░░░░░░░░░░      ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
]]

local default_opts = {
    position = "center",
    width = 60,
    shrink_margin = true,
    align_shortcut = "right",
    wrap = "overflow"
}

function alpha_config.init()
    alpha_config.start("startup", true)
end

function alpha_config.start(name, init)
    if init then
        alpha.setup(alpha_config.menus[name])
    else
        alpha.start(false, alpha_config.menus[name])
    end
end

function alpha_config.bookmarks()
    local bookmarks_table = {
        { "v", "", "neovim config", ":e $DOTFILES/.config/nvim/init.vim" },
        { "z", "", "zshrc", ":e $DOTFILES/.zshrc" },
        { "b", "", "bspwm config", ":e $DOTFILES/.config/bspwm/bspwmrc" },
        { "s", "", "sxhkd config", ":e $DOTFILES/.config/sxhkd/sxhkdrc" },
        { "x", "", "xresources", ":e $DOTFILES/.Xresources" },
    }

    local bookmarks_buttons = { }

    -- bookmark[1] = key to press
    -- bookmark[2] = icon
    -- bookmark[3] = title of bookmark
    -- bookmark[4] = command
    for _, bookmark in pairs(bookmarks_table) do
        local file_button = menu.button(utils.deepcopy(default_opts),
            bookmark[2], bookmark[3], bookmark[1], bookmark[1], bookmark[4] .. "<CR>")
        bookmarks_buttons[#bookmarks_buttons + 1] = file_button
    end

    bookmarks_buttons[#bookmarks_buttons + 1] = menu.padding({ }, 1)
    bookmarks_buttons[#bookmarks_buttons + 1] =
        menu.button(
            utils.deepcopy(default_opts),
            "", "Back", "h", "h", ":lua require('alpha-config').start('startup')<CR>"
        )

    return {
        type = "group",
        val = bookmarks_buttons,
        opts = { }
    }
end

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

function alpha_config.mru(start, cwd)
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
            oldfiles[#oldfiles + 1] = v
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
        local index_keymap = tostring(i - 1)
        --local file_button = button(tostring(i + start - 1), ico .. "  " .. short_fn , ":e " .. fn .. " <CR>")
        local file_button = menu.button(utils.deepcopy(default_opts),
            ico, short_fn, index_keymap, index_keymap, ":e " .. fn .. "<CR>")
        --if hl then file_button.opts.hl = { { hl, 0, 1 } } end -- starts at val and not shortcut
        tbl[#tbl + 1] = file_button
    end

    tbl[#tbl + 1] = menu.padding({ }, 1)
    tbl[#tbl + 1] =
        menu.button(
            utils.deepcopy(default_opts),
            "", "Back", "h", "h", ":lua require('alpha-config').start('startup')<CR>"
        )

    return {
        type = "group",
        val = tbl,
        opts = {
        }
    }
end

alpha_config.menus = {
    startup = {
        layout = {
            menu.header(utils.deepcopy(default_opts), header_text),

            menu.padding({ }, 2),

            menu.button(utils.deepcopy(default_opts),
                "", "Bookmarks", "b", "b", ":lua require('alpha-config').start('bookmarks')<CR>"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Recent Files", "r", "r", ":lua require('alpha-config').start('recentfiles')<CR>"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Sessions", "s", "s", ":e $DOTFILES/.config/nvim/init.vim<CR>"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Search Files", "f", "f", ":Files<CR>"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Quit", "q", "q", ":qa<CR>"),
        },
        opts = {
            margin = 3
        }
    },
    bookmarks = {
        layout = {
            menu.header(utils.deepcopy(default_opts), header_text),
            menu.padding({ }, 2),
            alpha_config.bookmarks()
        },
        opts = {
            margin = 3
        }
    },
    recentfiles = {
        layout = {
            menu.header(utils.deepcopy(default_opts), header_text),
            menu.padding({ }, 2),
            alpha_config.mru()
        },
        opts = {
            margin = 3
        }
    }
}

return alpha_config
