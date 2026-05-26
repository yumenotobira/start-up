local keymap = vim.keymap.set

keymap("n", "<C-e>", "<cmd>Neotree toggle filesystem left<cr>", {
  silent = true,
  desc = "Toggle file tree",
})

keymap("n", "<C-f>", "<cmd>FzfLua files<cr>", {
  silent = true,
  desc = "Find files",
})

keymap("n", "<C-g>", "<cmd>FzfLua live_grep<cr>", {
  silent = true,
  desc = "Live grep",
})

vim.api.nvim_create_user_command("B", function()
  require("fzf-lua").buffers()
end, {})

