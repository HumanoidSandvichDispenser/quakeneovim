#! /usr/bin/env lua
--
-- plugins.lua
-- Copyright (C) 2021 sandvich <sandvich@manjaro>
--
-- Distributed under terms of the MIT license.
--

local packer = require("packer")

packer.init()

local function plugins(use)
    -- Packer can manage itself

    use("wbthomason/packer.nvim")

    -- themes

    use("rktjmp/lush.nvim")

    use({
        "ellisonleao/gruvbox.nvim",
        opt = true,
        as = "gruvbox"
    })

    use({
        "navarasu/onedark.nvim",
        opt = true,
        as = "onedark"
    })

    use({
        "ghifarit53/tokyonight-vim",
        opt = true,
        as = "tokyonight"
    })

    use({
        "easysid/mod8.vim",
        opt = true,
        as = "mod8"
    })

    use({
        "franbach/miramare",
        opt = true,
        as = "miramare"
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

    use("christoomey/vim-conflicted")

    -- Autocomplete
    use({
        "neoclide/coc.nvim",
        branch = "release",
        event = "BufRead"
    })

    use("Quramy/tsuquyomi")

    use("williamboman/vim-import-ts")

    -- Snippets

    use("honza/vim-snippets")

    -- Auto tabbing / Alignment

    use("godlygeek/tabular")

    -- Language Support

    use("plasticboy/vim-markdown")

    use("lervag/vimtex")

    use("rafcamlet/coc-nvim-lua") -- Nvim lua support for CoC

    use("OmniSharp/omnisharp-vim") -- Omnisharp (C#)

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

    use("superevilmegaco/Screenshot.nvim")

    use("justinmk/vim-sneak") -- Sneak mode

    use("chrisbra/Colorizer")

    use("jbyuki/instant.nvim")
end

-- delayed lazy loading
vim.fn.timer_start(100, function()
    vim.o.laststatus = 2
    packer.loader("feline.nvim")
end)

return packer.startup({
    plugins,
    config = {
        profile = {
            enable = true,
            threshold = 0
        }
    }
})
