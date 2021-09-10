#! /usr/bin/env lua
--
-- galaxyline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local galaxyline = require("galaxyline")
local condition = require("galaxyline.condition")
local colors = require("highlight-overrides").BaseColors

local function mode_alias(m)
    local alias = {
        n = "NORMAL",
        i = "INSERT",
        c = "COMMAND",
        R = "REPLACE",
        t = "TERMINAL",
        [""] = "V-BLOCK",
        V = "V-LINE",
        v = "VISUAL",
    }

    return alias[m] or ""
end

local function mode_color(m)
    local mode_colors = {
        normal =  colors.fg,
        insert =  colors.green,
        visual =  colors.blue,
        replace =  colors.purple,
    }

    local color = {
        n = mode_colors.normal,
        i = mode_colors.insert,
        c = mode_colors.replace,
        R = mode_colors.replace,
        t = mode_colors.insert,
        [""] = mode_colors.visual,
        V = mode_colors.visual,
        v = mode_colors.visual,
    }

    return color[m] or colors.bg2
end

-- disable for these file types
galaxyline.short_line_list = { "startify", "nerdtree", "term", "fugitive", "NvimTree" }

local current_working_dir = {
    CWD = {
        separator = " ",
        icon = "פּ ",
        separator_highlight = { colors.bg2, colors.bg1 } ,
        highlight = {colors.white, colors.bg2},
        provider = function()
          local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          return dirname .. " "
        end,
    }
}

local file_icon = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = { colors.gray, colors.bg1 },
    }
}

local file_name = {
    FileName = {
        provider = "FileName",
        condition = condition.buffer_not_empty,
        highlight = { colors.gray, colors.bg1 },
        --separator_highlight = { colors.bg1, colors.bg },
        --separator = "  ",
    }
}

local file_size = {
    FileSize = {
        provider = "FileSize",
        condition = condition.buffer_not_empty,
        highlight = { colors.gray, colors.bg1 },
    }
}

local diff_add = {
    DiffAdd = {
        icon = "+",
        separator = "",
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        highlight = { colors.green, colors.bg1 },
        separator_highlight = { colors.green, colors.bg1 },
    }
}

local diff_modified = {
    DiffModified = {
        icon = "~",
        separator = "",
        provider = "DiffModified",
        condition = condition.hide_in_width,
        highlight = {colors.blue, colors.bg1},
        separator_highlight = { colors.green, colors.bg1 },
    }
}

local diff_remove = {
    DiffRemove = {
        icon = "-",
        separator = "",
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        highlight = {colors.red, colors.bg1},
        separator_highlight = { colors.green, colors.bg1 },
    }
}

local file_type = {
    FileType = {
        highlight = { colors.gray, colors.bg1 },
        provider = function()
          local buf = require("galaxyline.provider_buffer")
          return string.lower(buf.get_buffer_filetype())
        end,
    }
}

local git_branch = {
    GitBranch = {
        icon = " ",
        separator = "  ",
        condition = condition.check_git_workspace,
        highlight = {colors.aqua, colors.bg},
        provider = "GitBranch",
    }
}

local file_location = {
    FileLocation = {
        icon = " ",
        separator = " ",
        separator_highlight = {colors.bg_dark, colors.bg},
        highlight = {colors.gray, colors.bg_dark},
        provider = function()
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")

            if current_line == 1 then
                return "Top"
            elseif current_line == total_lines then
                return "Bot"
            end

            local percent, _ = math.modf((current_line / total_lines) * 100)
            return "" .. percent .. "%"
        end,
    }
}

vim.api.nvim_command("hi GalaxyViModeReverse guibg=" .. colors.bg_dark)

local vi_mode = {
    ViMode = {
        icon = " ",
        separator = " ",
        separator_highlight = "GalaxyViModeReverse",
        highlight = {colors.bg0, mode_color()},
        provider = function()
            local m = vim.fn.mode() or vim.fn.visualmode()
            local mode = mode_alias(m)
            local color = mode_color(m)
            --vim.api.nvim_command("hi GalaxyViMode guibg=" .. color)
            --vim.api.nvim_command("hi GalaxyViModeReverse guifg=" .. color)
            vim.api.nvim_command(string.format("hi GalaxyViMode guibg=%s", color))
            vim.api.nvim_command(string.format("hi GalaxyViModeReverse guifg=%s guibg=%s", color, colors.bg2))
            return " " .. mode .. " "
        end,
    }
}

galaxyline.section.left = {
    vi_mode,
    current_working_dir,
    file_icon,
    file_name,
    file_size,
    file_type,
}

galaxyline.section.right = {
    git_branch,
    diff_add,
    diff_modified,
    diff_remove,
    file_location,
}
