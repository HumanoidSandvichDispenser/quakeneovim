return {
  "mason-org/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  cmd = "Mason",
  opts = {
    ensure_installed = {
      "lua_ls",
      "pyright",
      "tsserver",
      "rust_analyzer",
      "clangd",
      "gopls",
      "jsonls",
      "yamlls",
      "html",
      "cssls",
    },
  },
}
