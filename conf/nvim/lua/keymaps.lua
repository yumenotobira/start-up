local keymap = vim.keymap.set

vim.g.mapleader = " "

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

keymap("n", "<C-b>", "<cmd>FzfLua buffers<cr>", {
  silent = true,
  desc = "Find buffers",
})

keymap("n", "H", "<C-w>h", {
  silent = true,
  desc = "Move to left window",
})

keymap("n", "L", "<C-w>l", {
  silent = true,
  desc = "Move to right window",
})

keymap("n", "<leader>gp", "<cmd>Octo pr list<cr>", {
  silent = true,
  desc = "List GitHub pull requests",
})

keymap("n", "<leader>gi", "<cmd>Octo issue list<cr>", {
  silent = true,
  desc = "List GitHub issues",
})

keymap("n", "<leader>gs", function()
  require("octo.utils").create_base_search_command({ include_current_repo = true })
end, {
  silent = true,
  desc = "Search GitHub",
})

keymap("n", "<leader>gn", "<cmd>Octo notification list<cr>", {
  silent = true,
  desc = "List GitHub notifications",
})

keymap("n", "<leader>gr", "<cmd>Octo review<cr>", {
  silent = true,
  desc = "Start GitHub review",
})

keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", {
  silent = true,
  desc = "Open git diff view",
})

keymap("n", "<leader>gD", "<cmd>DiffviewOpen origin/main...HEAD<cr>", {
  silent = true,
  desc = "Open branch diff view",
})

keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", {
  silent = true,
  desc = "Open file history",
})

keymap("n", "<leader>gq", "<cmd>DiffviewClose<cr>", {
  silent = true,
  desc = "Close diff view",
})
