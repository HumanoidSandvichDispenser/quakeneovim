#! /usr/bin/env lua
--
-- indent-line-config.lua
-- Copyright (C) 2021 sandvich <sandvich@arch>
--
-- Distributed under terms of the MIT license.
--

local indent_line_config = {}

--[[
let g:indentLine_color_term = 8
"let g:indentLine_char = '┆'
let g:indentLine_char = '│'
let g:indentLine_color_gui = '#504945'
let g:indent_blankline_filetype_exclude = [ 'man', 'startify', 'NvimTree', 'dashboard', 'alpha' ]
]]

function indent_line_config.init()
    require("indent_blankline").setup({
        char = "│",
        filetype_exclude = { "man", "startify", "NvimTree", "dashboard", "alpha" },
        show_end_of_line = true
    })
end


return indent_line_config
