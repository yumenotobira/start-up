require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },

  current_line_blame = false,
})

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", {
  silent = true,
  desc = "Show git diff",
})

vim.keymap.set("n", "<leader>gb", function()
  vim.ui.input({
    prompt = "Base branch: ",
    default = "origin/main",
  }, function(base)
    if not base or base == "" then
      return
    end

    vim.cmd("DiffviewOpen " .. vim.fn.fnameescape(base) .. "...HEAD")
  end)
end, {
  silent = true,
  desc = "Show git diff against base branch",
})

vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", {
  silent = true,
  desc = "Close git diff view",
})
