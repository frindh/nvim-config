-- TODO new nvim-treesitter (main branch) works differently
-- it is enabled with autocmd, probably need to add keymaps per buffer in autocmd
-- require("nvim-treesitter.config").setup({
--     highlight = { enable = true },
--     indent = { enable = true },
--     incremental_selection = {
--         enable = true,
--         keymaps = {
--             init_selection = "gnn",    -- new node
--             node_incremental = "grn",  -- refactor/tree node
--             node_decremental = "grm",  -- refactor/tree minus
--             scope_incremental = "grc", -- refactor/tree container/scope
--         },
--     },
-- })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "nix", "python", "go", "html", "json", "java", "c", "cpp", "css" },
    callback = function(ev)
        vim.treesitter.start(ev.buf)

        -- folds
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        -- vim.wo.foldlevel = 99
        --
        -- indent
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})


local move = require("nvim-treesitter-textobjects.move")

vim.keymap.set({ "n", "x", "o" }, "]f", function()
    move.goto_next_start("@function.outer", "textobjects")
end, { silent = true })

vim.keymap.set({ "n", "x", "o" }, "[f", function()
    move.goto_previous_start("@function.outer", "textobjects")
end, { silent = true })

-- classes
vim.keymap.set({ "n", "x", "o" }, "]c", function()
    move.goto_next_start("@class.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[c", function()
    move.goto_previous_start("@class.outer", "textobjects")
end)

-- parameters
vim.keymap.set({ "n", "x", "o" }, "]a", function()
    move.goto_next_start("@parameter.inner", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "[a", function()
    move.goto_previous_start("@parameter.inner", "textobjects")
end)
