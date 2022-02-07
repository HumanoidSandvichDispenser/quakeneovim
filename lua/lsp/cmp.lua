local cmp = require("cmp")
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")

-- completes if a completion popup menu is visible, otherwise register a
-- newline normally.
local function complete()
    if cmp.visible() then
        --cmp.complete()
        cmp.mapping.confirm({ select = true })
    else
        --vim.fn.feedkeys("\n")
        local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        vim.api.nvim_feedkeys(key, "n", true)
    end
end

local function next(is_next, keyname)
    if cmp.visible() then
        if is_next then
            cmp.select_next_item()
        else
            cmp.select_prev_item()
        end
    else
        print(keyname)
        local key = vim.api.nvim_replace_termcodes(tostring(keyname), true, false, true)
        vim.api.nvim_feedkeys(key, "n", true)
    end
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({  map_char = { tex = "" } }))

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item()
    },
    experimental = {
        ghost_text = true,
    },
    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    sources = {
        {
            name = "nvim_lsp",
        },
        {
            name = "vsnip",
        },
        {
            name = "buffer",
        },
        {
            name = "path",
        }
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 32
        })
    }
})

return {
    complete = complete,
    next = next,
}
