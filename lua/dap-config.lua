#! /usr/bin/env lua
--
-- dap-config.lua
-- Copyright (C) 2023 sandvich <sandvich@artix>
--
-- Distributed under terms of the MIT license.
--

local dap = require("dap")

local function setup()
    local mason_pkg_path = vim.fn.stdpath("data") .. "/mason/packages"
    dap.adapters.godot_mono = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
    }

    dap.adapters.coreclr = {
        type = "executable",
        command = mason_pkg_path .. "/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
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
            request = "attach",
            mode = "playInEditor",
        },
        {
            name = "Launch netcoredbg",
            type = "coreclr",
            request = "launch",
            program = function()
                return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/.godot/mono/temp/bin/Debug/", "file")
            end
        },
    }

    print("Set up dap")
end

return {
    setup = setup,
}
