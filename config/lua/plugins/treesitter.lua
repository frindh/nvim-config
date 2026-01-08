require("nvim-treesitter.config").setup({
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",    -- new node
            node_incremental = "grn",  -- refactor/tree node
            node_decremental = "grm",  -- refactor/tree minus
            scope_incremental = "grc", -- refactor/tree container/scope
        },
    },
})
