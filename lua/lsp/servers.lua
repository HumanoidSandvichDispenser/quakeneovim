local lspconfig = require("lspconfig")

local configs = {
    tsserver = { },
    lua_ls = require("lsp.lua-server"),
    bashls = {
        filetypes = {
            "sh",
            "bash",
            "zsh"
        }
    },
    clangd = { },
    pyright = { },
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
    },
    gopls = { },
    --tailwindcss = { },
    cssls = { },
    volar = {
        init_options = {
            typescript = {
                tsdk = "/usr/lib/node_modules/typescript/lib",
            },
        },
        filetypes = {
            "typescript",
            "vue",
        },
    },
    typst_lsp = {
        root_dir = function ()
            return vim.loop.cwd()
        end
    },
    intelephense = {
        root_dir = function ()
            return vim.loop.cwd()
        end
    },
    --fennel_language_server = {
    --    settings = {
    --        fennel = {
    --            workspace = {
    --                -- If you are using hotpot.nvim or aniseed,
    --                -- make the server aware of neovim runtime files.
    --                library = vim.api.nvim_list_runtime_paths(),
    --            },
    --        },
    --    },
    --},
    --fennel_ls = {

    --}
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
