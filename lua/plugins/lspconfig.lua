return {
  "neovim/nvim-lspconfig",
  dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
  event = "VeryLazy",
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- LSP server configuration table
    local lsp_servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      },
      copilot = { },
      csharp_ls = { },
      pyright = { },
      vtsls = { },
      vue_ls = { },
      rust_analyzer = { },
      clangd = { },
      gopls = { },
      jsonls = { },
      yamlls = { },
      html = { },
      cssls = { },
    }

    -- Configure each LSP server
    for server, config in pairs(lsp_servers) do
      if type(config) == "table" then
        config.capabilities = capabilities
        vim.lsp.config(server, config)
      end
    end

    -- Enable all configured LSP servers
    vim.lsp.enable(vim.tbl_keys(lsp_servers))
  end,
}
