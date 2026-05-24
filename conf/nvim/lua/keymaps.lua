local keymap = vim.keymap.set

keymap("n", "<C-e>", "<cmd>Neotree toggle filesystem left<cr>", {
  silent = true,
  desc = "Toggle file tree",
})

keymap("n", "<C-f>", "<cmd>Neotree reveal filesystem left<cr>", {
  silent = true,
  desc = "Reveal current file in tree",
})
