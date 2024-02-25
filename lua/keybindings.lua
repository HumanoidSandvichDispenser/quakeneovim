#! /usr/bin/env lua
--
-- keybindings.lua
-- Copyright (C) 2022 sandvich <sandvich@archtop>
--
-- Distributed under terms of the MIT license.
--

local keybindings = {}
local which_key = require("which-key")
local telescope_builtin = require("telescope.builtin")
local telescope_config = require("telescope-config")
local dap = require("dap")
local zen_mode = require("zen-mode")

function keybindings.map_leaders()
    --which_key.register({
    --    ["<leader>"] = { telescope_builtin.buffers, "Switch buffer" },
    --}, { prefix = "<leader>" })

    -- buffers
    which_key.register({
        b = {
            name = "buffer",
            b = { telescope_builtin.buffers, "Switch buffer" },
            d = { "<cmd>BD<CR>", "Kill buffer" },
        }
    }, { prefix = "<leader>" })

    -- window
    which_key.register({
        w = {
            name = "window",
            h = { "<C-w>h", "Go to the left window" },
            j = { "<C-w>j", "Go to the down window" },
            k = { "<C-w>k", "Go to the up window" },
            l = { "<C-w>l", "Go to the right window" },
            q = { "<C-w>q", "Quit a window" },
            z = { zen_mode.toggle, "Zen mode" }
        }
    }, { prefix = "<leader>", mode = "n" })

    -- code
    which_key.register({
        c = {
            name = "code",
            r = { "<cmd>Telescope lsp_references<CR>", "References" },
            R = { function()
                    vim.lsp.buf.rename()
                end,
                "Rename"
            },
            c = {
                function ()
                    vim.lsp.buf.code_action()
                end,
                "Code actions"
            },
            k = { "<C-w>k" },
            l = { "<C-w>l" },
            q = { "<C-w>q" },
        }
    }, { prefix = "<leader>" })

    -- files
    which_key.register({
        f = {
            name = "file",
            r = { telescope_builtin.oldfiles, "Recent files" },
            f = { telescope_builtin.git_files, "Find files (git)" },
            F = { telescope_builtin.find_files, "Find files" },
            p = { telescope_config.search_config_dir, "Config files" },
        }
    }, { prefix = "<leader>" })

    -- search
    which_key.register({
        s = {
            name = "search",
            s = { telescope_builtin.current_buffer_fuzzy_find, "Swipe" },
            t = { telescope_builtin.current_buffer_tags, "Tags (current buffer)" },
            T = { telescope_builtin.tags, "Tags" },
            g = { telescope_builtin.live_grep, "grep" },
            r = { telescope_builtin.grep_string, "Regex" },
        }
    }, { prefix = "<leader>" })

    -- debug
    which_key.register({
        d = {
            name = "debug",
            d = { dap.toggle_breakpoint, "Toggle breakpoint" },
            i = { dap.step_into, "Step into" },
            o = { dap.step_over, "Step over" },
            c = { dap.continue, "Continue" },
        },
    }, { prefix = "<leader>" })

    -- zettelkasten
    which_key.register({
        z = {
            name = "zettelkasten",
            n = { "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", "New note" },
            z = { "<cmd>ZkNotes<CR>", "Notes" },
            t = { "<cmd>ZkTags<CR>", "Tags" },
            l = { "<cmd>ZkLinks<CR>", "Links" },
            b = { "<cmd>ZkBacklinks<CR>", "Backlinks" },
            i = { "<cmd>ZkInsertLink<CR>", "Insert link" },
        },
    }, { prefix = "<leader>" })

    which_key.register({
        z = {
            name = "zettelkasten",
            n = { ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", "New note" },
            t = { ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", "New note with title" },
        }
    }, { mode = "v", prefix = "<leader>", noremap = true, silent = false })
end

function keybindings.map_select()
    local enter_select = "<C-o>v<C-g>"
    local enter_visual = "<C-o>v"

    which_key.register({
        ["<S-Left>"] = {
            "<Left>" .. enter_select,
            "Select left"
        },
        ["<C-S-Left>"] = {
            --"<Left>" .. enter_select .. "<C-Left>",
            "<Left>" .. enter_visual .. "b<C-g>",
            "Select left word"
        },
        ["<S-Right>"] = {
            enter_select .. "<Right>",
            "Select right"
        },
        ["<C-S-Right>"] = {
            enter_visual .. "e<C-g>",
            "Select right word"
        },
        ["<S-Home>"] = {
            enter_select .. "<Home>",
            "Select to beginning of line"
        },
        ["<S-End>"] = {
            enter_select .. "<End>",
            "Select to end of line"
        },
    }, { mode = "i" })

    which_key.register({
        ["<Left>"] = {
            "<Esc>",
            "Left"
        },
        ["<Right>"] = {
            "<Esc><Right>",
            "Right"
        },
        ["<S-Left>"] = {
            "<Left>",
            "Select left"
        },
        ["<C-S-Left>"] = {
            "<C-o>b",
            "Select left word"
        },
        ["<S-Right>"] = {
            "<Right>",
            "Select right"
        },
        ["<C-S-Right>"] = {
            "<C-o>e",
            "Select right word"
        },
        ["<Home>"] = {
            "<Esc><Home>",
            "Beginning of line"
        },
        ["<End>"] = {
            "<Esc><End>",
            "End of line"
        },
    }, { mode = "s" })
end

function keybindings.setup()
    --keybindings.map_leaders()
    --keybindings.map_select()
end

return keybindings
