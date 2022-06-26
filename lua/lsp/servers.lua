local lspconfig = require("lspconfig")

local configs = {
    tsserver = { },
    sumneko_lua = require("lsp.lua-server"),
    bashls = {
        filetypes = {
            "sh",
            "bash",
            "zsh"
        }
    },
    clangd = { },
    pyright = { },
    vuels = { },
    texlab = { },
    rust_analyzer = { },
    --omnisharp = {
    --    use_mono = true
    --},
    csharp_ls = {

    },
    gdscript = {
        on_attach = function (client)
            local _notify = client.notify
            client.notify = function (method, params)
                if method == "textDocument/didClose" then
                    -- Godot doesn't implement didClose yet
                    return
                end
                _notify(method, params)
            end
        end,
        flags = {
            debounce_text_changes = 500,
        }
    }
}

return {
    load_language_servers = function()
        for k, config in pairs(configs) do
            local server = lspconfig[k]

            if server ~= nil then
                server.setup(config)
            end
        end
    end
}
