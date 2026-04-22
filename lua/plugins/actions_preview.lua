return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {
      "gf",
      mode = { "n", "v" },
      function()
        require("actions-preview").code_actions()
      end,
      desc = "Actions Preview",
    },
  },
}
