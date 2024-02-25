#! /usr/bin/env lua
--
-- treesitter-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local orgmode = require("orgmode")
orgmode.setup_ts_grammar()

local parsers = require("nvim-treesitter.parsers")
local configs = require("nvim-treesitter.configs")

local parser_configs = parsers.get_parser_configs()

--parser_configs.blade = {
--    install_info = {
--        url = "https://github.com/EmranMR/tree-sitter-blade",
--        files = {"src/parser.c"},
--        branch = "main",
--    },
--    filetype = "blade"
--}

configs.setup({
    --ensure_installed = { "org" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = {
            "markdown",
            "tex",
            "latex",
        },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "org" },
    },
    indent = {
        enable = true,
        disable = { "markdown" }
    },
})

orgmode.setup({
    org_agenda_files = { "~/sync" },
    org_default_notes_file = "~/sync/Notes.org",
    org_hide_leading_stars = true,
    org_ellipsis = " "
})
