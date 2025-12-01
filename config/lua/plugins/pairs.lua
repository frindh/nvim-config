require("mini.pairs").setup({
  modes = { insert = true, command = false, terminal = false },

  -- Avoid autopairing inside snippets when jumping
  mappings = {
    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][^%w]" },
    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][^%w]" },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][^%w]" },
  },
})

