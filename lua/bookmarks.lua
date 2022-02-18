return {
    "neovim",
    { "v", "", "neovim config", ":e $NVIM/init.vim" },
    { "p", "", "neovim plugins", ":e $NVIM/lua/plugins.lua" },
    { "l", "", "language servers", ":e $NVIM/lua/lsp/servers.lua" },
    { "B", "", "bookmarks file", ":e $NVIM/lua/bookmarks.lua"},
    { "fP", "", "configuration directory", ":Files $NVIM"},
    "etc",
    { "z", "", "zshrc", ":e $DOTFILES/.zshrc" },
    { "b", "", "bspwm config", ":e $DOTFILES/.config/bspwm/bspwmrc" },
    { "s", "", "sxhkd config", ":e $DOTFILES/.config/sxhkd/sxhkdrc" },
    { "x", "", "xresources", ":e $DOTFILES/.Xresources" },
}
