local LSP = require("lsp")

LSP.setup_server("nixd", {
    settings = {
        nixd = {
            formatting = { command = { "alejandra" } },
        },
    },
})

