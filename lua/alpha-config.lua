#! /usr/bin/env lua
--
-- alpha-config.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local alpha_config = {}

function alpha_config.init()
    local alpha = require("alpha")
    local dashboard = require("alpha-theme")
    alpha.setup(dashboard.opts)
end

return alpha_config
