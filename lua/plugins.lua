#! /usr/bin/env lua
--
-- plugins.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

--local packer = require("packer")

local lazy = require("lazy")

vim.o.laststatus = 0 -- this will be set to 2 after feline starts

local plugins = {
    {
        "rktjmp/hotpot.nvim",
        dependencies = {
            "HumanoidSandvichDispenser/themis.nvim",
        }
    },

    {
        "HumanoidSandvichDispenser/themis.nvim",
        submodules = false,
    },

    "udayvir-singh/hibiscus.nvim",

    -- which-key + keybindings
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({
                plugins = {
                    presets = {
                        motions = false,
                        operators = false,
                        text_objects = false,
                    }
                }
            })
        end
    },

    -- themes
    {
        dir = "~/git/lush-themes",
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            vim.cmd("source /var/tmp/colorscheme.vim")
        end
    },

    "rktjmp/lush.nvim",

    -- Templates for new files
    "aperezdc/vim-template",

    -- Show indents
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },

    "timakro/vim-yadi",

    -- Project drawer

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim"
        },
        config = function()
            require("telescope-config").init()
        end
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },

    -- Status line
    {
        "feline-nvim/feline.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            vim.o.laststatus = 2
            require("feline-config")
        end
    },

    "qpkorr/vim-bufkill", -- Kill buffer without removing split

    -- Git
    "tpope/vim-fugitive",

    "mhinz/vim-signify",

    {
        "NeogitOrg/neogit", -- magit for neovim
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        keys = { "<leader>" },
        config = function()
            require("neogit").setup({
                signs = {
                    item = { "", "" },
                    section = { "", "" },
                },
            })
        end
    },

    -- LSP and Autocomplete

    {
        "neoclide/coc.nvim",
        lazy = true,
        branch = "release"
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim"
        },
        config = function()
            require("mason").setup()
            require("lsp.servers").load_language_servers()
            require("lsp.config")
        end
    },

    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("lsp.cmp")
        end
    },

    {
        "hrsh7th/vim-vsnip",
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "kitagry/vs-snippets"
        },
        config = function()
            vim.g.vsnip_snippet_dir = "$HOME/.config/vsnip"
        end
    },

    "onsails/lspkind-nvim",

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    },

    {
        "windwp/nvim-ts-autotag",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "html", "xml", "php", "vue "},
        config = function()
            require("nvim-treesitter.configs").setup({
                autotag = {
                    enable = true,
                    filetypes = { "html", "xml", "php", "vue" },
                },
            })
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({})
        end
    },

    -- Debugger

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("dap-config").setup()
        end
    },

    {
        "rcarriga/nvim-dap-ui",
    },

    -- Language Support

    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            vim.g.vimtex_compiler_method = "latexrun"
        end
    },

    {
        "vim-pandoc/vim-pandoc",
        dependencies = {
            {
                "vim-pandoc/vim-pandoc-syntax",
                ft = "markdown"
            }
        },
        ft = "markdown"
    },

    {
        "kovetskiy/sxhkd-vim",
        ft = "sxhkd"
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("treesitter-config")
        end
    },

    {
        "nvim-treesitter/playground",
        lazy = true,
        config = function()
            require("nvim-treesitter.configs").setup({
                playground = {
                    enable = true
                }
            })
        end
    },

    {
        "kaarmu/typst.vim",
        ft = { "typst" }
    },

    {
        "atweiden/vim-fennel",
        ft = { "fennel" }
    },

    -- Other Utilities

    "ryanoasis/vim-devicons",       -- Icons

    "kyazdani42/nvim-web-devicons", -- Colored icons

    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha-config").init()
        end
    },

    "rest-nvim/rest.nvim",

    {
        "mickael-menu/zk-nvim",
        config = function()
            require("zk").setup({
                picker = "fzf",
                lsp = {
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                    },
                    auto_attach = {
                        enabled = true,
                        filetypes = { "markdown" },
                    }
                },
            })
        end
    },

    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require("leap")
            vim.keymap.set("n", "s", function()
                leap.leap({
                    target_windows = { vim.fn.win_getid() }
                })
            end)
        end
    },

    "chrisbra/Colorizer",

    {
        "jbyuki/instant.nvim",
        lazy = true
    },

    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    width = 80,
                }
            })
        end
    },

    "dstein64/nvim-scrollview",

    "junegunn/vim-easy-align",

    {
        "nvim-orgmode/orgmode",
        config = function()
            require("orgmode").setup({
                org_agenda_files = { "~/sync/agenda.org" },
                org_startup_indented = true,
                org_adapt_indentation = false,
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    },

    "danro/rename.vim",
}

lazy.setup(plugins)
