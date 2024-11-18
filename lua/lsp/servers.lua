local lspconfig = require("lspconfig")

local configs = {
    --tsserver = { },
    ts_ls = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = "",
                    languages = { "vue" },
                }
            }
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    },
    lua_ls = require("lsp.lua-server"),
    bashls = {
        filetypes = {
            "sh",
            "bash",
            "zsh"
        }
    },
    clangd = { },
    basedpyright = { },
    --pyright = { },
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
            vue = {
                hybridMode = true
            },
            --typescript = {
            --    tsdk = "/usr/lib/node_modules/typescript/lib",
            --},
        },
        --filetypes = {
        --    "typescript",
        --    "vue",
        --},
    },
    typst_lsp = {
        root_dir = function ()
            return vim.loop.cwd()
        end
    },
    --tinymist = {
    --    --root_dir = function ()
    --    --    return vim.loop.cwd()
    --    --end,
    --    exportPdf = "onType",
    --    outputPath = "$root/target/$dir/$name",
    --    settings = {
    --        exportPdf = "onType",
    --        outputPath = "$root/target/$dir/$name",
    --    },
    --    offset_encoding = "utf-8",
    --},
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
