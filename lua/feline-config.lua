#! /usr/bin/env lua
--
-- feline-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local feline = require("feline")
local vi_mode_utils = require("feline.providers.vi_mode")
local file_utils = require("feline.providers.file")
local cursor_utils = require("feline.providers.cursor")
local web_devicons = require("nvim-web-devicons")
local utils = require("utils")
local diagnostic = vim.diagnostic
local lsp = require("feline.providers.lsp")

-- Determines if the window's width is longer than the specified width
--
-- @return Returns `true` if the window is longer than `width`, otherwise `false`
local function is_window_longer_than(width)
    return vim.api.nvim_win_get_width(0) > width
end

-- Determines if the current buffer is an existing file, by looking for filesize
--
-- @return Returns `true` if the file under the buffer exists
local function is_valid_file()
    return vim.fn.getfsize(vim.fn.expand("%:p")) > 0
end

local function get_cursor_row()
    return vim.api.nvim_win_get_cursor(0)[1]
end

local function get_cursor_col()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    col = vim.str_utfindex(vim.api.nvim_get_current_line(), col) + 1
    return col
end

-- Ternary expression
--
-- @return `a` if `cond` is `true`, otherwise `b`
local function ternary(cond, a, b)
    if cond then
        return a
    end
    return b
end

local default_hl = "FelineDefault"

local vi_mode_colors = {
    NORMAL = "FelineNormalMode",
    INSERT = "FelineInsertMode",
    VISUAL = "FelineVisualMode",
    LINES = "FelineVisualMode",
    OP = "FelineVisualMode",
    BLOCK = "FelineVisualMode",
    REPLACE = "FelineReplaceMode",
    ["V-REPLACE"] = "FelineReplaceMode",
    ENTER = "FelineSelectMode",
    MORE = "FelineSelectMode",
    SELECT = "FelineSelectMode",
    COMMAND = "FelineCommandMode",
    SHELL = "FelineInsertMode",
    TERM = "FelineInsertMode",
    NONE = "FelineNormalMode"
}

-- This is a function so the highlights are dynamically updated
local function vi_mode_color_hl()
    return vi_mode_colors[vi_mode_utils.get_vim_mode()]
end

local vi_mode = {
    provider = function()
        local mode = vi_mode_utils.get_vim_mode()
        return " " .. mode .. " "
    end,
    right_sep = " ",
    hl = vi_mode_color_hl
}

local space = {
    provider = " ",
    hl = default_hl
}

local cwd = {
    provider = function()
        local dir = vim.fn.getcwd()
        local levels = utils.split(dir, "/")
        local topdir = levels[#levels]
        return topdir
    end,
    right_sep = {
        str = " | ",
        hl = default_hl
    },
    icon = "פּ ",
    hl = default_hl,
    enabled = function()
        return is_window_longer_than(100)
    end
}

local filepath = {
    provider = function()
        local full_path = vim.fn.resolve(vim.fn.expand("%:p:h"))
        if full_path then
            local relative_path = vim.fn.fnamemodify(full_path, ":~:.")
            local short_path = vim.fn.pathshorten(relative_path)
            if short_path then
                if short_path == "" then
                    short_path = "./"
                else
                    short_path = short_path .. "/"
                end
            end
            return short_path, { str = " " }
        end
        return ""
    end,
    icon = function()
        local fullname = vim.api.nvim_buf_get_name(0)
        local extension = vim.fn.fnamemodify(fullname, ":e")
        local icon, _ = web_devicons.get_icon_color(fullname, extension)
        if icon then
            return icon .. " "
        end
        return ""
    end,
    enabled = function()
        return is_window_longer_than(80) and is_valid_file()
    end,
    --left_sep = {
    --    str = " ",
    --    hl = default_hl
    --},
    hl = default_hl
}

local filename = {
    provider = function()
        local fullname = vim.api.nvim_buf_get_name(0)
        if fullname and fullname ~= "" then
            return vim.fn.fnamemodify(fullname, ":t")
        end

        return "no file"
    end,
    hl = function()
        return ternary(is_valid_file(), "Normal", "FelineDefault")
    end
}

local filename_inactive = utils.deepcopy(filename)
filename_inactive.hl = function()
    return default_hl
end


local filemod = {
    provider = function()
        local status = ""
        if vim.bo.mod then
            status = status .. " "
        end
        return status
    end,
    left_sep = {
        str = " ",
        hl = default_hl
    },
    hl = default_hl
}

local filesize = {
    provider = "file_size",
    left_sep = {
        str = " ",
        hl = default_hl
    },
    enabled = function()
        return is_valid_file() and is_window_longer_than(100)
    end,
    hl = default_hl
}

local filetype = {
    provider = function()
        return vim.bo.filetype
    end,
    left_sep = {
        str = " ",
        hl = default_hl
    },
    enabled = function()
        return is_valid_file() and is_window_longer_than(100)
    end,
    hl = default_hl
}

local lsp_name = {
    provider = "lsp_client_names",
    right_sep = {
        str = " ",
        hl = default_hl
    },
    icon = "  ",
    enabled = function()
        return is_valid_file() and is_window_longer_than(100)
    end,
    hl = default_hl
}

local function get_diagnostics(severity)
    return #diagnostic.get(0, { severity = severity })
end

local lsp_errors = {
    provider = "diagnostic_errors",
    icon = "  ",
    right_sep = {
        str = " ",
        hl = default_hl
    },
    enabled = function()
        return is_valid_file() and is_window_longer_than(120) and
            lsp.diagnostics_exist()
    end,
    hl = "FelineError"
}

local lsp_warnings = {
    provider = "diagnostic_warnings",
    icon = "  ",
    right_sep = {
        str = " ",
        hl = default_hl
    },
    enabled = function()
        return is_valid_file() and is_window_longer_than(120) and
            lsp.diagnostics_exist()
    end,
    hl = "FelineWarning"
}

local git_branch = {
    provider = function()
        return vim.fn.FugitiveHead(), ' '
    end,
    enabled = function()
        return vim.fn.FugitiveIsGitDir() and is_window_longer_than(120)
    end,
    right_sep = {
        str = " ",
        hl = default_hl
    },
    hl = default_hl,
}

local git_diffs = {
    provider = function()
        local result = ""
        local diffs = vim.fn["sy#repo#get_stats"]()
        if diffs[1] > 0 then
            result = result .. "+" .. diffs[1] .. " "
        end
        if diffs[2] > 0 then
            result = result .. "~" .. diffs[2] .. " "
        end
        if diffs[3] > 0 then
            result = result .. "-" .. diffs[3] .. " "
        end
        return result
    end,
    enabled = function()
        return vim.fn.FugitiveIsGitDir()
    end,
    right_sep = {
        str = "| ",
        hl = default_hl
    },
    hl = default_hl
}

local position_row = {
    provider = function()
        return tostring(get_cursor_row())
    end,
    right_sep = {
        str = ":",
        hl = default_hl
    },
    hl = default_hl
}

local position_col = {
    provider = function()
        return tostring(get_cursor_col())
    end,
    right_sep = {
        str = " ",
        hl = default_hl
    },
    hl = function()
        --return {
        --    fg = ternary(get_cursor_col() > 80, colors.red, default_hl),
        --    bg = colors.bg0
        --}
        return ternary(get_cursor_col() > 80, "FelineError", "Normal")
    end
}

local scroll_bar = {
    provider = "scroll_bar",
    hl = default_hl
}

local scroll = {
    provider = "line_percentage",
    right_sep = {
        str = " ",
        hl = default_hl
    },
    hl = default_hl
}

local components = {
    active = {
        {
            vi_mode,
            cwd,
            filepath,
            filename,
            filemod,
            filesize,
            filetype
        },
        {
            lsp_name,
            lsp_errors,
            lsp_warnings,
            git_branch,
            git_diffs,
            position_row,
            position_col,
            scroll,
            scroll_bar,
        }
    },
    inactive = {
        {
            space,
            filename_inactive,
            filemod,
            filesize,
            filetype,
            space
        }
    }
}

feline.setup({
    components = components
})
