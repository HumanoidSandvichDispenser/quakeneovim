#! /usr/bin/env lua
--
-- orgmode-config.lua
-- Copyright (C) 2021 sandvich <sandvich@arch>
--
-- Distributed under terms of the MIT license.
--

require("orgmode").setup({
    org_agenda_files = { "~/Documents/org/*", "~/Documents/**/*" },
    org_default_notes_file = "~/Documents/org/refile.org",
})
