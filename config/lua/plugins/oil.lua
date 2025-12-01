require("oil").setup({
    -- columns = {
    --     "permissions",
    --     "size",
    --     "mtime",
    --     -- no "icon"
    -- },
})

-- Open Oil in current buffer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
