#! /usr/bin/env lua
--
-- alpha-menu.lua
-- Copyright (C) 2021 sandvich <sandvich@arch>
--
-- Distributed under terms of the MIT license.
--
-- Module for writing quick Alpha menus

local alpha_menu = {}

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

function alpha_menu.button(opts, icon, text, keybind, key_appearance)
    if not key_appearance then
        key_appearance = keybind
    end

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

return alpha_menu
