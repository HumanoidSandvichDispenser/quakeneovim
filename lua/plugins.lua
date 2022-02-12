#! /usr/bin/env lua
--
-- plugins.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

vim.o.runtimepath = vim.o.runtimepath..',~/.local/share/nvim/site/pack/packer/start/himalaya/vim'

local packer = require("packer")
local util = require("packer.util")
local use = packer.use

packer.init({
    package_root = "/usr/share/nvim/plugins/pack",
    --compile_path = "/usr/share/nvim/plugins/packer_compiled.lua",
})

function LoadColorschemePlugin(colorscheme)
    vim.api.nvim_command("colorscheme " .. colorscheme)
    require("highlight-overrides").highlight_overrides()
end

-- Packer can manage itself

use("wbthomason/packer.nvim")

-- themes

--use("rktjmp/lush.nvim")

use({
    --"ellisonleao/gruvbox.nvim",
    "morhetz/gruvbox",
    opt = true, -- only load the colorscheme we need
    as = "gruvbox",
    config = function()
        LoadColorschemePlugin("gruvbox")
    end
})

use({
    "navarasu/onedark.nvim",
    opt = true,
    as = "onedark",
    config = function()
        LoadColorschemePlugin("onedark")
    end
})

use({
    "ghifarit53/tokyonight-vim",
    opt = true,
    as = "tokyonight",
    config = function()
        LoadColorschemePlugin("tokyonight")
    end
})

use({
    "easysid/mod8.vim",
    opt = true,
    as = "mod8",
    config = function()
        LoadColorschemePlugin("mod8")
    end
})

use({
    "franbach/miramare",
    opt = true,
    as = "miramare",
    config = function()
        LoadColorschemePlugin("miramare")
    end
})

-- Templates for new files
use("aperezdc/vim-template")

-- Show indents
use({
    "lukas-reineke/indent-blankline.nvim",
    config = require("indent-line-config").init
})

-- Project drawer

use("junegunn/fzf.vim")

use({
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
        require("nvim-tree-config")
    end
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

-- LSP and Autocomplete

use({
    "neoclide/coc.nvim",
    disable = true,
    branch = "release",
    event = "BufRead"
})

use({
    "neovim/nvim-lspconfig",
    config = function()
        require("lsp.servers").load_language_servers()
    end
})

use({
    "hrsh7th/nvim-cmp",
    requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip"
    },
    config = function()
        require("lsp.cmp")
    end
})

use({
    "hrsh7th/vim-vsnip",
    requires = {
        "hrsh7th/cmp-vsnip"
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

-- Language Support

use({
    "lervag/vimtex",
    ft = "tex",
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
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
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
