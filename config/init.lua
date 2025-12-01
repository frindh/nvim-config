-- Mark that init.lua was loaded (for debugging)
vim.g.loaded_init = true

-- Development mode warning
if vim.fn.stdpath("config") == vim.fn.expand("~/.config/nvim") then
  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      vim.defer_fn(function()
        vim.notify("Development mode - Using local config", vim.log.levels.WARN)
      end, 100)
    end,
  })
end

-- Load core configuration
require('core.options')
require('core.keymaps')
require('core.autocmds')

require("lsp")
require("lsp.python")
require("lsp.lua")
require("lsp.go")
require("lsp.nix")

require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.telescope")
--require("plugins.oil")
require("plugins.minifiles")
require("plugins.completion")
require("plugins.pairs")
