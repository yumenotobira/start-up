require("bufferline").setup({
  options = {
    mode = "buffers",

    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,

    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = "thin",

    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
  },
})

local keymap = vim.keymap.set

keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", {
  silent = true,
  desc = "Next buffer",
})

keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", {
  silent = true,
  desc = "Previous buffer",
})

keymap("n", "<leader>bd", function()
  local current = vim.api.nvim_get_current_buf()

  local others = vim.tbl_filter(function(buf)
    return buf ~= current and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  -- Switch the window to another buffer before deleting so the window
  -- (and nvim itself) stays open. Only the focused buffer is removed.
  if #others > 0 then
    vim.cmd("BufferLineCyclePrev")
  end

  vim.api.nvim_buf_delete(current, {})
end, {
  silent = true,
  desc = "Delete current buffer",
})

keymap("n", "<leader>bp", "<cmd>BufferLinePick<cr>", {
  silent = true,
  desc = "Pick buffer",
})

for i = 1, 9 do
  keymap("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", {
    silent = true,
    desc = "Go to buffer " .. i,
  })
end
