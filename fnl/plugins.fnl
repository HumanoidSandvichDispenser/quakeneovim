(import-macros {: spread!} :macros.macros)
(import-macros {: lazy-begin!
                : lazy-use!
                : lazy-spec!
                : lazy-end!
                : setup!
                : require-call!} :macros.plugins)

(lazy-begin!)

(lazy-use! rktjmp/hotpot.nvim
           :dependencies [:HumanoidSandvichDispenser/themis.nvim])

(lazy-use! HumanoidSandvichDispenser/themis.nvim
           :submodules false)

(lazy-use! udayvir-singh/hibiscus.nvim)

(lazy-use! folke/which-key.nvim
           :config (fn []
                     (setup! :which-key
                             {:plugins 
                               {:presets
                                 {:motions false
                                  :operators false
                                  :text_objects false}}})))

(lazy-use! lush-themes
           :dir "~/git/lush-themes"
           :priority 1000
           :config (fn []
                     (tset (. vim :opt) :termguicolors true)
                     (vim.cmd "source /var/tmp/colorscheme.vim")))

(lazy-use! rktjmp/lush.nvim)

(lazy-use! aperezdc/vim-template)

(lazy-use! lukas-reineke/indent-blankline.nvim
           :tag :v3.5.4
           :pin true
           :config (fn []
                     (setup! :ibl)))

(lazy-use! timakro/vim-yadi)

(lazy-use! nvim-telescope/telescope.nvim
           :dependencies [:nvim-lua/plenary.nvim
                          :nvim-telescope/telescope-file-browser.nvim]
           :config (fn []
                     (require-call! :telescope-config :init)))

(lazy-use! nvim-telescope/telescope-fzf-native.nvim
           :build :make)

(lazy-use! freddiehaddad/feline.nvim
           :lazy true
           :event :VeryLazy
           :config (fn []
                     (tset (. vim :o) :laststatus 2)
                     (require :feline-config)))

(lazy-use! qpkorr/vim-bufkill)

(lazy-use! tpope/vim-fugitive)

(lazy-use! mhinz/vim-signify)

(lazy-use! NeogitOrg/neogit
           :dependencies [:nvim-lua/plenary.nvim]
           :cmd :Neogit
           :config (fn []
                     (setup! :neogit {:signs {:item ["" ""]
                                              :section ["" ""]}})))

(lazy-use! neovim/nvim-lspconfig
           :dependencies [:williamboman/mason.nvim]
           :config (fn []
                     (setup! :mason)
                     ((. (require :lsp.servers) :load_language_servers))
                     (require :lsp.config)))

(lazy-use! hrsh7th/nvim-cmp
           :dependencies [:hrsh7th/cmp-nvim-lsp
                          :hrsh7th/cmp-buffer
                          :hrsh7th/cmp-path
                          :hrsh7th/cmp-cmdline
                          :hrsh7th/cmp-vsnip
                          :hrsh7th/cmp-nvim-lsp-signature-help
                          :hrsh7th/cmp-cmdline]
           :config (fn []
                     (require :lsp.cmp)))

(lazy-use! hrsh7th/vim-vsnip
           :dependencies [:hrsh7th/cmp-vsnip
                          :kitagry/vs-snippets]
           :config (fn []
                     (tset (. vim :g) :vsnip_snippet_dir "$HOME/.config/vsnip")))

(lazy-use! onsails/lspkind-nvim)

(lazy-use! windwp/nvim-autopairs
           :config (fn []
                     (setup! :nvim-autopairs {:disable_filetype [:lisp]})))

(lazy-use! windwp/nvim-ts-autotag
           :dependencies [:nvim-treesitter/nvim-treesitter]
           :ft [:html :xml :php :vue]
           :config (fn []
                     (setup! :nvim-treesitter.configs
                             {:autotag {:enable true
                                        :filetypes [:html :xml :php :vue]}})))

(lazy-use! folke/trouble.nvim
           :dependencies :kyazdani42/nvim-web-devicons
           :config (fn []
                     (setup! :trouble {})))

(lazy-use! mfussenegger/nvim-dap
           :config (fn []
                     (setup! :dap-config)))

(lazy-use! rcarriga/nvim-dap-ui)


;; language support

(lazy-use! lervag/vimtex
           :ft :tex
           :init (fn []
                   (tset (. vim :g) :vimtex_compiler_method :latexrun)))

(lazy-use! vim-pandoc/vim-pandoc
           :dependencies (lazy-spec! vim-pandoc/vim-pandoc-syntax
                                     :ft :markdown))

(lazy-use! kovetskiy/sxhkd-vim
           :ft :sxhkd)

(lazy-use! nvim-treesitter/nvim-treesitter
           :config (fn []
                     (require :treesitter-config)))

(lazy-use! kaarmu/typst.vim
           :ft [:typst])

(lazy-use! atweiden/vim-fennel
           :ft [:fennel])

;; lisp stuff

(lazy-use! dundalek/parpar.nvim
           :dependencies [:gpanders/nvim-parinfer
                          :julienvincent/nvim-paredit]
           :opts [])

(lazy-use! HiPhish/rainbow-delimiters.nvim
           :config (fn []
                     (setup! :rainbow-delimiters.setup
                             {:query {:commonlisp :rainbow-blocks}})))

(lazy-use! ryanoasis/vim-devicons)

(lazy-use! kyazdani42/nvim-web-devicons)

(lazy-use! goolord/alpha-nvim
           :config (fn []
                     (require-call! :alpha-config :init)))

(lazy-use! ggandor/leap.nvim)

(lazy-use! chrisbra/Colorizer)

(lazy-use! folke/zen-mode.nvim
           :config (fn []
                     (setup! :zen-mode
                             {:window {:width 80}})))

(lazy-use! dstein64/nvim-scrollview)

(lazy-use! junegunn/vim-easy-align)

(lazy-use! nvim-orgmode/orgmode
           :config (fn []
                     (setup! :orgmode
                             {:org_agenda_files ["~/sync/agenda.org"]
                              :org_startup_indented true
                              :org_adapt_indentation false})))

(lazy-use! danro/rename.vim)

(lazy-end!)
