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
    clangd = { }
}

return {
    load_language_servers = function()
        for k, config in pairs(configs) do
            local server = lspconfig[k]

            if server ~= nil then
                server.setup(config)
            else
                --warn(string.format("Language server %s does not exist in lspconfig.", k))
            end
        end
    end
}
