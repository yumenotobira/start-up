local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
    desc = "Go to definition",
  }))

  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
    desc = "Go to references",
  }))

  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
    desc = "Hover documentation",
  }))

  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, {
    desc = "Previous diagnostic",
  }))

  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, {
    desc = "Next diagnostic",
  }))
end

vim.lsp.config("ts_ls", {
  on_attach = on_attach,
})

vim.lsp.config("pyright", {
  on_attach = on_attach,
})

vim.lsp.enable({
  "ts_ls",
  "pyright",
})
