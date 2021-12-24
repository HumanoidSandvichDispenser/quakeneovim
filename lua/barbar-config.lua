#! /usr/bin/env lua
--
-- barbar-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

vim.g.bufferline = {
    animation = false,
    auto_hide = true,
    tabpages = false,
    closable = true,
    clickable = true,
    icons = true,
    icon_custom_colors = false,
    icon_separator_active = '',
    icon_separator_inactive = '',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    maximum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title = nil,
}
