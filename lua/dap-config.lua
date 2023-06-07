#! /usr/bin/env lua
--
-- dap-config.lua
-- Copyright (C) 2023 sandvich <sandvich@artix>
--
-- Distributed under terms of the MIT license.
--

local dap = require("dap")

local function setup()
    dap.adapters.godot_mono = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
    }

    --dap.adapters.coreclr = {
    --    type = "executable",
    --    executable = {
    --        command = "/home/sandvich/git/godot/bin/godot.linuxbsd.editor.x86_64.mono",
    --        args = {
    --            "--path",
    --            "${workspaceRoot}"
    --        }
    --    }
    --}

    dap.configurations.cs = {
        {
            name = "Godot Mono: Play in Editor",
            type = "godot_mono",
            request = "launch",
            mode = "playInEditor",
        }
    }

    print("Set up dap")
end

return {
    setup = setup,
}
