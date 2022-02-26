#! /usr/bin/env lua
--
-- alpha-menu.lua
-- Copyright (C) 2021 sandvich <sandvich@arch>
--
-- Distributed under terms of the MIT license.
--
-- Module for writing quick Alpha menus

local alpha_menu = {}

local utils = require("utils")

function alpha_menu.padding(opts, size)
    return {
        type = "padding",
        val = size,
        opts = opts,
    }
end

function alpha_menu.group(opts, elements)
    return {
        type = "group",
        val = elements,
        opts = opts
    }
end

function alpha_menu.button(opts, icon, text, keybind, key_appearance, action)
    if not key_appearance then
        key_appearance = keybind
    end

    if not opts then
        opts = { }
    end

    opts.shortcut = key_appearance
    opts.cursor = 5
    opts.hl = "Accent"
    opts.hl_shortcut = "Normal"

    if not keybind then
        opts.keymap = { "n", keybind, action, { noremap = false, silent = true } }
    end

    --[[
    if type(action) == "function" then
        opts.keymap = { "n", keybind, action, { noremap = false, silent = true } }
    else
        opts.keymap = { "n", keybind, action, { noremap = false, silent = true } }
    end
    ]]
    return {
        type = "button",
        val = icon .. "  " .. text,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(keybind, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts
    }
end

function alpha_menu.header(opts, text)
    if not opts then
        opts = { }
    end

    opts.hl = "Gray"

    return {
        type = "text",
        val = utils.split(text, "\n"),
        opts = opts
    }
end

function alpha_menu.label(opts, text)
    if not opts then
        opts = { }
    end

    return {
        type = "text",
        val = text,
        opts = opts
    }
end

return alpha_menu
