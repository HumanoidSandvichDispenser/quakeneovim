return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "Issafalcon/neotest-dotnet",
  },
  keys = {
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Neotest run nearest",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Neotest run file",
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Neotest stop",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Neotest output",
    },
    {
      "<leader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Neotest summary",
    },
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-python")({
          dap = {
            justMyCode = false,
          },
          runner = "pytest",
        }),
        require("neotest-plenary"),
        -- Adapter for .NET projects (uses `dotnet test`)
        require("neotest-dotnet"),
      },
      icons = {
        passed = "",
        running = "",
        failed = "",
        skipped = "",
      },
      quickfix = {
        enabled = false,
      },
      status = {
        virtual_text = true,
      },
      summary = {
        open = "right",
      },
    })
  end,
}
