#! /usr/bin/env lua
--
-- keybindings.lua
-- Copyright (C) 2022 sandvich <sandvich@archtop>
--
-- Distributed under terms of the MIT license.
--

local keybindings = {}
local which_key = require("which-key")
local telescope_builtin = require("telescope")
local dap = require("dap")

function keybindings.map_leaders()
    which_key.register({
        ["<leader>"] = { telescope_builtin.buffers, "Switch buffer" },
    }, { prefix = "<leader>" })

    -- buffers
    which_key.register({
        b = {
            name = "buffer",
            b = { telescope_builtin.buffers, "Switch buffer" },
            d = { "<cmd>bd<CR>", "Kill buffer" },
        }
    }, { prefix = "<leader>" })

    -- window
    which_key.register({
        w = {
            name = "window",
            h = { "<C-w>h" },
            j = { "<C-w>j" },
            k = { "<C-w>k" },
            l = { "<C-w>l" },
            q = { "<C-w>q" },
        }
    }, { prefix = "<leader>" })

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
        }
    }, { prefix = "<leader>" })

    -- search
    which_key.register({
        s = {
            name = "search",
            s = { telescope_builtin.current_buffer_fuzzy_find, "Swipe" },
            t = { telescope_builtin.current_buffer_tags, "Tags (current buffer)" },
            T = { telescope_builtin.tags, "Tags" },
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
    keybindings.map_leaders()
    keybindings.map_select()
end

return keybindings
