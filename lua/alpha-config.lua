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

local possible_headers = {
    [[

   .d'     'b.
  d'         `b
.$'           `$.                                          .
dF             9b     9$     $F         $.         9F    .P       9F   `$
$L             J$     $$     $$        d`$.        $$  .dP        $$
Y$             $P     $$     $$       d' $$.       $$*'Y$b.       $$*
`$b    9$F    d$'     $$     $$      d' `"$$.      $$    `$b      $$
 `$b.  8$8  .d$'      Y$.   .$P     d'     $$.     $$      $      "$  .:$
   "$$@@$@@$$"         `'" "'`                             '       `"'`"'
     `"Y$P"'
       I$I                         N E O V I M
       `$'
        $
        *
    ]],
    --[[
      ▓▓▓▓  ▓▓▓▓
    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ███████   █████   ██████  ██    ██ ██ ██████████
  ▓▓▓▓██  ████  ▓▓  ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓     ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒     ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
▓▓▓▓▓▓▓▓▓▓▓▓▓▓       ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
░░░░░░░░░░░░░░      ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
    ]]
}

--math.randomseed(os.time())
--local header_text = possible_headers[math.random(1, #possible_headers)]
local header_text = possible_headers[1]

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
    local bookmarks_table = require("bookmarks")

    local bookmarks_buttons = { }

    -- bookmark[1] = key to press
    -- bookmark[2] = icon
    -- bookmark[3] = title of bookmark
    -- bookmark[4] = command
    for i, bookmark in pairs(bookmarks_table) do
        -- a string indicates it is a label
        if type(bookmark) == "string" then
            if i > 0 then
                local padding = menu.padding(default_opts, 1)
                bookmarks_buttons[#bookmarks_buttons + 1] = padding
            end

            local label = menu.label(utils.deepcopy(default_opts), bookmark)
            bookmarks_buttons[#bookmarks_buttons + 1] = label
        -- a table indicates it is a bookmark
        elseif type(bookmark) == "table" then
            local file_button = menu.button(utils.deepcopy(default_opts),
                bookmark[2], bookmark[3], bookmark[1], bookmark[1], bookmark[4]
                .. "<CR>")
            bookmarks_buttons[#bookmarks_buttons + 1] = file_button
        end

    end

    bookmarks_buttons[#bookmarks_buttons + 1] = menu.padding({ }, 1)
    bookmarks_buttons[#bookmarks_buttons + 1] =
        menu.button(
            utils.deepcopy(default_opts),
            "", "Back", "h", "h", ":bd | lua require('alpha-config').start('startup')<CR>"
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

function alpha_config.mru(_, cwd)
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
        local ico, _ = icon(fn)
        local short_fn
        if cwd then
            short_fn = vim.fn.fnamemodify(fn, ":.")
        else
            short_fn = vim.fn.fnamemodify(fn, ":~")
        end
        local fn_length = short_fn:len()
        local MAX_LEN = 52
        if fn_length > MAX_LEN then
            local trim_len = fn_length - MAX_LEN
            short_fn = "..." .. short_fn:sub(3 + trim_len, fn_length)
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
            "", "Back", "h", "h", ":bd | lua require('alpha-config').start('startup')<CR>"
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
            menu.padding({ }, 1),

            menu.header(utils.deepcopy(default_opts), header_text),

            menu.padding({ }, 2),

            menu.button(utils.deepcopy(default_opts),
                "", "New File", "e", "e", ":enew<CR>"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Bookmarks", nil, "b"),

            menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Recent Files", nil, "SPC f r"),

            menu.padding({ }, 1),

            --menu.button(utils.deepcopy(default_opts),
            --    "", "Mail", nil, "SPC o m"),

            --menu.padding({ }, 1),

            menu.button(utils.deepcopy(default_opts),
                "", "Back", "h", "h", ":bd<CR>"),

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
            menu.padding({ }, 1),
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
            menu.padding({ }, 1),
            menu.header(utils.deepcopy(default_opts), header_text),
            menu.padding({ }, 2),
        },
        opts = {
            margin = 3
        }
    },
    utils = {
        layout = {
            menu.padding({ }, 1),
            menu.header(utils.deepcopy(default_opts), header_text),
            menu.padding({ }, 2),
            alpha_config
        }
    }
}

return alpha_config
