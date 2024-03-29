#! /usr/bin/env lua
--
-- nvim-tree-config.lua
-- Copyright (C) 2021 sandvich <sandvich@arch>
--
-- Distributed under terms of the MIT license.
--

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
    view = {
        mappings = {
            list = {
                { key = "h",                            cb = tree_cb("dir_up") },
                { key = "l",                            cb = tree_cb("cd")},
                { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
                { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
                { key = "<C-v>",                        cb = tree_cb("vsplit") },
                { key = "<C-x>",                        cb = tree_cb("split") },
                { key = "<C-t>",                        cb = tree_cb("tabnew") },
                { key = "<",                            cb = tree_cb("prev_sibling") },
                { key = ">",                            cb = tree_cb("next_sibling") },
                { key = "P",                            cb = tree_cb("parent_node") },
                { key = "<BS>",                         cb = tree_cb("close_node") },
                { key = "<S-CR>",                       cb = tree_cb("close_node") },
                { key = "<Tab>",                        cb = tree_cb("preview") },
                { key = "K",                            cb = tree_cb("first_sibling") },
                { key = "J",                            cb = tree_cb("last_sibling") },
                { key = "I",                            cb = tree_cb("toggle_ignored") },
                { key = "H",                            cb = tree_cb("toggle_dotfiles") },
                { key = "R",                            cb = tree_cb("refresh") },
                { key = "a",                            cb = tree_cb("create") },
                { key = "d",                            cb = tree_cb("remove") },
                { key = "r",                            cb = tree_cb("rename") },
                { key = "<C-r>",                        cb = tree_cb("full_rename") },
                { key = "x",                            cb = tree_cb("cut") },
                { key = "c",                            cb = tree_cb("copy") },
                { key = "p",                            cb = tree_cb("paste") },
                { key = "y",                            cb = tree_cb("copy_name") },
                { key = "Y",                            cb = tree_cb("copy_path") },
                { key = "gy",                           cb = tree_cb("copy_absolute_path") },
                { key = "[c",                           cb = tree_cb("prev_git_item") },
                { key = "]c",                           cb = tree_cb("next_git_item") },
                { key = "-",                            cb = tree_cb("dir_up") },
                { key = "s",                            cb = tree_cb("system_open") },
                { key = "q",                            cb = tree_cb("close") },
                { key = "g?",                           cb = tree_cb("toggle_help") },
            }
        }
    },
    renderer = {
        group_empty = true,
        indent_markers = {
            enable = true
        },
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "M ",
                    staged = "S ",
                    unmerged = "G ",
                    renamed = "R ",
                    untracked = "U ",
                    deleted = "D ",
                    ignored = "I ",
                },
                folder = {
                    default = " ",
                    open = " ",
                    symlink = " ",
                    empty = " ",
                    empty_open = " ",
                    symlink_open = " ",
                }
            },
        },
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    git = {
        enable = false
    }
})


