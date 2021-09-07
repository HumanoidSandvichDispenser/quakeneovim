#! /usr/bin/env lua
--
-- xresources.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local Xresources = {}

function Xresources.get(key)
    --local command = io.popen("xrdb -query | grep " .. key .. " -m 1 | cut -f 2")
    local command = io.popen("xgetres " .. key)
   return command:read("*l")
end

return Xresources
