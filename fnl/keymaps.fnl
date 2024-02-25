(import-macros {: let!} :themis.var)
(import-macros {: map!} :themis.keybind)

;; set leader
;(vim.cmd "map <space> <leader>")
(let! mapleader " ")

;; shortcuts
(map! [niv] "<ScrollWheelUp>" "3<C-Y>")
(map! [niv] "<ScrollWheelDown>" "3<C-E>")
(map! [niv] "<C-s>" "<cmd>w<CR>")
(map! [niv] "<C-s>" "<cmd>w<CR>")

;; remappings
(map! [nvo] ";" ":")
(map! [n] "Y" "yy")
(map! [n] "j" "gj" {:silent true})
(map! [n] "k" "gk" {:silent true})
(map! [n] "Q" "gqq" {:silent true})

;; emacs insert mappings
(map! [i] "<C-a>" "<C-o>^")
(map! [i] "<C-e>" "<C-o>$")
(map! [i] "<C-b>" "<Left>")
(map! [i] "<C-f>" "<Right>")
(map! [i] "<C-n>" "<Down>")
(map! [i] "<C-p>" "<Up>")
(map! [i] "<C-h>" "<C-w>")
(map! [i] "<C-BS>" "<C-w>")
(map! [i] "<C-k>" "<C-o>dd")

;; M-x
(map! [i] "<M-x>" "<cmd>Telescope<CR>" {:silent true})

;; LSP
(map! [n] "gd" vim.lsp.buf.definition {:silent true})
(map! [n] "K" vim.lsp.buf.hover {:silent true})

;; which-key bindings
(let [which-key (require :which-key)
      telescope-builtin (require :telescope.builtin)
      telescope-config (require :telescope-config)
      dap (require :dap)
      zen-mode (require :zen-mode)]

  (which-key.register
    {:<leader> [telescope-builtin.buffers "Switch buffer"]}
    {:prefix :<leader>})

  ;; buffer
  (which-key.register {:b {:b [telescope-builtin.buffers "Switch buffer"]
                           :d [:<cmd>BD<CR> "Kill buffer"]
                           :name :buffer}}
                      {:prefix :<leader>})

  ;; run
  (which-key.register {:r {:name :run
                           :f [:<cmd>Fnl<CR> "Run Fennel"]
                           :s ["<cmd>source %<CR>" "Source current file"]}}
                      {:prefix :<leader>})

  ;; window
  (which-key.register {:w {:name :window
                           :h [:<C-w>h "Go to the left window"]
                           :j [:<C-w>j "Go to the down window"]
                           :k [:<C-w>k "Go to the up window"]
                           :l [:<C-w>l "Go to the right window"]
                           :q [:<C-w>q "Quit a window"]
                           :z [zen-mode.toggle "Zen mode"]}}
                      {:mode :n :prefix :<leader>})

  ;; code
  (which-key.register {:c {:name :code
                           :R [(fn [] (vim.lsp.buf.rename)) :Rename]
                           :c [(fn [] (vim.lsp.buf.code_action))
                               "Code actions"]
                           :k [:<C-w>k]
                           :l [:<C-w>l]
                           :q [:<C-w>q]
                           :r ["<cmd>Telescope lsp_references<CR>"
                               :References]}}
                      {:prefix :<leader>})

  ;; files
  (which-key.register {:f {:name :file
                           :F [telescope-builtin.find_files "Find files"]
                           :f [telescope-builtin.git_files "Find files (git)"]
                           :p [telescope-config.search_config_dir
                               "Config files"]
                           :r [telescope-builtin.oldfiles "Recent files"]}}
                      {:prefix :<leader>})

  ;; search
  (which-key.register {:s {:name :search
                           :T [telescope-builtin.tags :Tags]
                           :g [telescope-builtin.live_grep :grep]
                           :r [telescope-builtin.grep_string :Regex]
                           :s [telescope-builtin.current_buffer_fuzzy_find
                               :Swipe]
                           :t [telescope-builtin.current_buffer_tags
                               "Tags (current buffer)"]}}
                      {:prefix :<leader>})

  ;; git
  (which-key.register {:g {:name :git
                           :g [:<cmd>Neogit<CR> "Neogit"]}}
                      {:prefix :<leader>})

  ;; debug
  (which-key.register {:d {:name :debug
                           :c [dap.continue :Continue]
                           :d [dap.toggle_breakpoint "Toggle breakpoint"]
                           :i [dap.step_into "Step into"]
                           :o [dap.step_over "Step over"]}}
                      {:prefix :<leader>})

  (let [enter-select :<C-o>v<C-g>
        enter-visual :<C-o>v]
    (which-key.register {:<C-S-Left> [(.. :<Left> enter-visual :b<C-g>)
                                      "Select left word"]
                         :<C-S-Right> [(.. enter-visual :e<C-g>)
                                       "Select right word"]
                         :<S-End> [(.. enter-select :<End>)
                                   "Select to end of line"]
                         :<S-Home> [(.. enter-select :<Home>)
                                    "Select to beginning of line"]
                         :<S-Left> [(.. :<Left> enter-select) "Select left"]
                         :<S-Right> [(.. enter-select :<Right>) "Select right"]}
                        {:mode :i})
    (which-key.register {:<C-S-Left> [:<C-o>b "Select left word"]
                         :<C-S-Right> [:<C-o>e "Select right word"]
                         :<End> [:<Esc><End> "End of line"]
                         :<Home> [:<Esc><Home> "Beginning of line"]
                         :<Left> [:<Esc> :Left]
                         :<Right> [:<Esc><Right> :Right]
                         :<S-Left> [:<Left> "Select left"]
                         :<S-Right> [:<Right> "Select right"]}
                        {:mode :s})))
