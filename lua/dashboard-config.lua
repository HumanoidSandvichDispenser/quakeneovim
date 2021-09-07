#! /usr/bin/env lua
--
-- dashboard-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--


local dashboard_config = {}

vim.g.dashboard_custom_shortcut = {
    ["last_session"] = "SPC s l",
    ["find_history"] = "SPC f h",
    ["find_file"] = "SPC f f",
    ["new_file"] = "SPC f n",
    ["change_colorscheme"] = "SPC f c",
    ["find_word"] = "SPC f w",
    ["book_marks"] = "SPC b",
}

return dashboard_config
