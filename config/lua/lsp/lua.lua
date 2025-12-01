local LSP = require("lsp")

LSP.setup_server("lua_ls", {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

