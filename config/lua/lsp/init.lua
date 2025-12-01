-- Shared LSP utilities
local M = {}

-- Shared on_attach
function M.on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    if client:supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

-- Default capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Simple server setup
function M.setup_server(name, opts)
    opts = opts or {}

    local cmd = opts.cmd and opts.cmd[1] or name
    if vim.fn.executable(cmd) == 0 then
        vim.notify("LSP server not found: " .. cmd, vim.log.levels.WARN)
        return
    end

    opts.on_attach = opts.on_attach or M.on_attach
    opts.capabilities = vim.tbl_deep_extend(
        "force",
        M.capabilities,         -- default capabilities
        opts.capabilities or {} -- user overrides
    )

    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
end

return M
