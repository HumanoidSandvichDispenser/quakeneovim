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
    --pylsp = { },
    pyright = { },
    vuels = { }
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
