#! /usr/bin/env lua
--
-- alpha-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

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

local header = {
    type = "text",
    val = utils.split(header_text, "\n"),
    opts = {
        hl = "Type"
        -- wrap = "overflow";
    }
}

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "left",
        shortcut = ""..sc.." ",
        cursor = 0,
        -- width = 50,
        align_shortcut = "left",
        hl_shortcut = "Number",
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
        if #oldfiles == 10 then break end
        local cwd_cond
        if not cwd
            then cwd_cond = true
            else cwd_cond = vim.fn.filereadable(v) == 1
        end
        if (vim.fn.filereadable(v) == 1) and cwd_cond then
            oldfiles[#oldfiles+1] = v
        end
    end

    local tbl = {}
    local function icon(fn)
        if pcall(require, 'nvim-web-devicons')
        then
            local nvim_web_devicons = require('nvim-web-devicons')
            local ext = fn:match("^.+(%..+)$"):sub(2)
            return nvim_web_devicons.get_icon(fn, ext, { default = true })
        else
            return '', nil
        end
    end
    for i, fn in pairs(oldfiles) do
        local ico, hl = icon(fn)
        local short_fn
        if cwd
            then short_fn = vim.fn.fnamemodify(fn, ':.')
            else short_fn = vim.fn.fnamemodify(fn, ':~')
        end
        local file_button = button(tostring(i+start-1), ico .. '  ' .. short_fn , ":e " .. fn .. " <CR>")
        if hl then file_button.opts.hl = { { hl, 0, 1 } } end -- starts at val and not shortcut
        tbl[#tbl+1] = file_button
    end
    return {
        type = "group",
        val = tbl,
        opts = {
        }
    }
end


local section = {
    header = header,
}

local opts = {
    layout = {
        {type = "padding", val = 2},
        section.header,
        {type = "padding", val = 2},
        button("e", "New file", ":ene <BAR> startinsert <CR>"),
        {type = "padding", val = 1},
        {type = "text", val = "MRU", opts = { hl = "Comment" }},
        {type = "padding", val = 1},
        mru(0),
        {type = "padding", val = 1},
        {type = "text", val = "MRU " .. vim.fn.getcwd() , opts = { hl = "Comment" }},
        {type = "padding", val = 1},
        mru(10, vim.fn.getcwd()),
        {type = "padding", val = 1},
        button("q", "Quit", ":q <CR>"),
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
