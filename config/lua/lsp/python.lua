local lsp = require("lsp")

-- Ruff
lsp.setup_server("ruff", {
    cmd = { "ruff", "server" },
})

-- Pyright
lsp.setup_server("pyright", {
    settings = {
        pyright = { disableOrganizeImports = true },
        python = { analysis = { ignore = { "*" } } },
    },
})

-- Disable Ruff's hover (Pyright has better)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("disable_ruff_hover", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
})

