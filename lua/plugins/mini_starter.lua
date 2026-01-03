local startup_text = [[
   .d'     'b.
  d'         `b
.$'           `$.                                          .
dF             9b     9$     $F         $.         9F    .P       9F   `$
$L             J$     $$     $$        d`$.        $$  .dP        $$
Y$             $P     $$     $$       d' $$.       $$*'Y$b.       $$*
`$b    9$F    d$'     $$     $$      d' `"$$.      $$    `$b      $$
 `$b.  8$8  .d$'      Y$.   .$P     d'     $$.     $$      $      "$  .:$
   "$$@@$@@$$"         `'" "'`                             '       `"'`"'
     `"Y$P"'
       I$I                         N E O V I M
       `$'
        $
        *
]]

return {
  "nvim-mini/mini.starter",
  lazy = false,
  config = function()
    require("mini.starter").setup({
      header = startup_text,
      footer = "",
    })
    vim.api.nvim_set_hl(0, "MiniStarterHeader", { link = "Gray", force = true })
  end,
}
