#! /usr/bin/env luaplug
--
-- plugins.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

vim.o.runtimepath = vim.o.runtimepath .. ',~/.local/share/nvim/site/pack/packer/start/himalaya/vim'

local packer = require("packer")
local util = require("packer.util")
local use = packer.use

vim.o.laststatus = 0 -- this will be set to 2 after feline starts

packer.init({
    package_root = "/usr/share/nvim/plugins/pack",
    --compile_path = "/usr/share/nvim/plugins/packer_compiled.lua",
})

-- Packer can manage itself

use("wbthomason/packer.nvim")

-- themes

use({ "~/git/lush-themes" })

use("rktjmp/lush.nvim")

-- Templates for new files
use("aperezdc/vim-template")

-- Show indents
use({
    "lukas-reineke/indent-blankline.nvim",
    config = require("indent-line-config").init
})

-- Project drawer

use({
    "nvim-telescope/telescope.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function()
        require("telescope-config").init()
    end
})

use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
})

use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    disable = true,
    config = function()
        require("nvim-tree-config")
    end
})

use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "Neotree",
    requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    }
})

-- Status line
use({
    "glepnir/galaxyline.nvim",
    disable = true,
    config = function()
        require("galaxyline-config")
    end
})

use({
    "feline-nvim/feline.nvim",
    opt = true,
    setup = function()
        --vim.o.laststatus = 2
    end,
    config = function()
        require("feline-config")
    end
})

use({
    "romgrk/barbar.nvim",
    opt = true,
    event = "WinEnter",
    -- setup() instead of config() since the bufferline will appear before the config is loaded
    setup = function()
        require("barbar-config")
    end
})

use("qpkorr/vim-bufkill") -- Kill buffer without removing split

-- Git
use("tpope/vim-fugitive")

use("mhinz/vim-signify")

use({
    "TimUntersberger/neogit",
    requires = {
        "nvim-lua/plenary.nvim"
    }
})

-- LSP and Autocomplete

use({
    "neoclide/coc.nvim",
    opt = true,
    branch = "release"
})

use({
    "neovim/nvim-lspconfig",
    requires = {
        "williamboman/nvim-lsp-installer"
    },
    config = function()
        require("nvim-lsp-installer").setup({})
        require("lsp.servers").load_language_servers()
        require("lsp.config")
    end
})

use({
    "hrsh7th/nvim-cmp",
    requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-nvim-lsp-signature-help"
    },
    config = function()
        require("lsp.cmp")
    end
})

use({
    "hrsh7th/vim-vsnip",
    requires = {
        "hrsh7th/cmp-vsnip",
        "kitagry/vs-snippets"
    },
    config = function()
        vim.g.vsnip_snippet_dir = "$HOME/.config/vsnip"
    end
})

use("onsails/lspkind-nvim")

use({
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup()
    end
})

use({
    "ray-x/navigator.lua",
    requires = {
        { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
        { "neovim/nvim-lspconfig" },
    },
    disable = true,
    config = function()
        require("navigator").setup()
    end
})

use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup({ })
    end
})

-- Language Support

use({
    "lervag/vimtex",
    ft = "tex",
    setup = function()
        vim.g.vimtex_compiler_method = "latexrun"
    end
})

use({
    "rafcamlet/coc-nvim-lua",
    disable = true
})

use({
    "vim-pandoc/vim-pandoc",
    requires = {
        {
            "vim-pandoc/vim-pandoc-syntax",
            ft = "markdown"
        }
    },
    ft = "markdown"
})

use({
    "kovetskiy/sxhkd-vim",
    ft = "sxhkdrc"
})

use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("treesitter-config")
    end
})

-- Other Utilities

use("ryanoasis/vim-devicons") -- Icons

use("kyazdani42/nvim-web-devicons") -- Colored icons

use({
    "goolord/alpha-nvim",
    config = function()
        require("alpha-config").init()
    end
})

use("justinmk/vim-sneak") -- Sneak mode

use("chrisbra/Colorizer")

use({
    "jbyuki/instant.nvim",
    opt = true
})

use("dstein64/nvim-scrollview")

use({
    "soywod/himalaya",
    config = function()
        vim.g.himalaya_mailbox_picker = "fzf"
    end
}) -- email

use("junegunn/vim-easy-align")

use({
    "nvim-orgmode/orgmode",
    config = function()
        require("orgmode").setup({})
    end,
    requires = {
        "nvim-treesitter/nvim-treesitter"
    }
})

use("svermeulen/vimpeccable")

-- delayed lazy loading
vim.fn.timer_start(100, function()
    vim.o.laststatus = 2
    packer.loader("feline.nvim")
    require("nvim-autopairs").setup()
end)

--[[
return packer.startup({
    plugins,
    config = {
        package_root = "/usr/share/nvim/plugins/pack",
        compile_path = "/usr/share/nvim/plugins/pack/packer_compiled.lua",
        profile = {
            enable = true,
            threshold = 0
        }
    }
})
--]]
