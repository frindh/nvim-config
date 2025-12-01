require("mini.icons").setup()

local mf = require("mini.files")
mf.setup({
    windows = {
        -- preview = true,
    },
    options = {
        use_as_default_explorer = true,
    },

})


vim.keymap.set("n", "<leader>e", function()
    mf.open()
end, { desc = "Open mini.files" })

vim.keymap.set("n", "<leader>E", function()
    mf.open(vim.fn.expand("%:p:h"))
end, { desc = "Open mini.files in current file directory" })
