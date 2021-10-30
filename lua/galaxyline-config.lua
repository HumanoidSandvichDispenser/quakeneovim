#! /usr/bin/env lua
--
-- galaxyline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local galaxyline = require("galaxyline")
local condition = require("galaxyline.condition")
local vcs = require("galaxyline.provider_vcs")
local fileinfo = require("galaxyline.provider_fileinfo")
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
        s = "SELECT",
    }

    return alias[m] or ""
end

local function mode_color(m)
    local mode_colors = {
        normal =  colors.fg,
        insert =  colors.green,
        visual =  colors.blue,
        replace =  colors.purple,
        select = colors.aqua,
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
        s = mode_colors.select
    }

    return color[m] or colors.bg2
end

-- disable for these file types
galaxyline.short_line_list = { "startify", "nerdtree", "term", "fugitive", "NvimTree" }

local current_working_dir = {
    CWD = {
        separator = " ",
        icon = "פּ ",
        highlight = { colors.white, colors.bg2 },
        separator_highlight = { colors.bg2, colors.bg1 },
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

local file_path = {
    FilePath = {
        separator = "",
        highlight = { colors.gray, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
        condition = function()
            return condition.hide_in_width() and condition.buffer_not_empty()
        end,
        provider = function()
            return vim.fn.expand("%:p:h") .. "/"
        end,
    }
}

local file_name = {
    FileName = {
        --provider = "FileName",
        separator = "",
        highlight = { colors.gray, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
        provider = function()
            local current_file_name = fileinfo.get_current_file_name()
            if not current_file_name or current_file_name == "" then
                return "No buffer "
            else
                return current_file_name
            end
        end,
        --separator_highlight = { colors.bg1, colors.bg },
        --separator = "  ",
    }
}

local file_size = {
    FileSize = {
        provider = "FileSize",
        separator = "",
        highlight = { colors.gray, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
        condition = function()
            return condition.buffer_not_empty() and condition.hide_in_width()
        end,
    }
}

local file_type = {
    FileType = {
        separator = "",
        highlight = { colors.gray, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
        condition = function()
            return condition.buffer_not_empty() and condition.hide_in_width()
        end,
        provider = function()
            return vim.bo.filetype
        end,
    }
}

local diff_add = {
    DiffAdd = {
        icon = "+",
        separator = "",
        provider = "DiffAdd",
        condition = function()
            return condition.hide_in_width() and condition.check_git_workspace()
        end,
        highlight = { colors.green, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
    }
}

local diff_modified = {
    DiffModified = {
        icon = "~",
        separator = "",
        provider = "DiffModified",
        condition = function()
            return condition.hide_in_width() and condition.check_git_workspace()
        end,
        highlight = { colors.blue, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
    }
}

local diff_remove = {
    DiffRemove = {
        icon = "-",
        separator = "",
        provider = "DiffRemove",
        highlight = { colors.red, colors.bg1 },
        separator_highlight = { colors.bg1, colors.bg1 },
        condition = function()
            return condition.hide_in_width() and condition.check_git_workspace()
        end,
    }
}

local git_branch = {
    GitBranch = {
        icon = "  ",
        separator = "",
        condition = condition.check_git_workspace,
        highlight = "GalaxyViMode",
        separator_highlight = "GalaxyViModeReverse",
        provider = function()
            return vcs.get_git_branch() .. " "
        end,
    }
}

-- right separator; without this component, the separator will belong to
-- diff_add, which may only render IF vim is in a git repository, and the
-- window is long enough.
local git_branch_right_separator = {
    GitBranchRightSeparator = {
        icon = " ",
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = "GalaxyViModeReverseBg1",
        provider = function() return nil end
    }
}

-- only display if the git branch component is visible (when
-- condition.check_git_workspace is true)
local file_position_separator = {
    FilePositionSeparator = {
        separator = "",
        separator_highlight = { colors.bg2, colors.bg1 },
        condition = condition.check_git_workspace,
        provider = function() return nil end
    }
}

local file_position = {
    FilePosition = {
        highlight = { colors.fg, colors.bg2 },
        provider = function()
            return " " .. vim.fn.col(".") .. ":" .. vim.fn.line(".") .. " "
        end
    }
}

local file_location = {
    FileLocation = {
        icon = "  ",
        separator = "",
        separator_highlight = "GalaxyViModeReverse",
        highlight = "GalaxyViMode",
        --[[provider = function()
            local current_line = vim.fn.line(".")
            local total_lines = vim.fn.line("$")

            if current_line == 1 then
                return "Top "
            elseif current_line == total_lines then
                return "Bot "
            end

            local percent, _ = math.modf((current_line / total_lines) * 100)
            return percent .. "% "
        end,]]
        provider = "LinePercent"
    }
}

local file_encoding = {
    FileEncoding = {
        separator = " ",
        separator_highlight = { colors.bg2, colors.bg1 },
        highlight = { colors.fg, colors.bg2 },
        provider = function()
            return fileinfo.get_file_encode() .. " "
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
            if not mode then mode = "MODE" .. m:upper() end
            local color = mode_color(m)
            --vim.api.nvim_command("hi GalaxyViMode guibg=" .. color)
            --vim.api.nvim_command("hi GalaxyViModeReverse guifg=" .. color)
            vim.api.nvim_command(string.format("hi GalaxyViMode guibg=%s", color))
            vim.api.nvim_command(string.format("hi GalaxyViModeReverse guifg=%s guibg=%s", color, colors.bg2))
            vim.api.nvim_command(string.format("hi GalaxyViModeBg1 guifg=%s guibg=%s", colors.bg1, color))
            vim.api.nvim_command(string.format("hi GalaxyViModeBg2 guifg=%s guibg=%s", colors.bg2, color))
            vim.api.nvim_command(string.format("hi GalaxyViModeReverseBg1 guifg=%s guibg=%s", color, colors.bg1))
            vim.api.nvim_command(string.format("hi GalaxyViModeReverseBg2 guifg=%s guibg=%s", color, colors.bg2))
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
    file_type
}

galaxyline.section.right = {
    file_encoding,
    git_branch,
    git_branch_right_separator,
    diff_add,
    diff_modified,
    diff_remove,
    file_position_separator,
    file_position,
    file_location,
}
