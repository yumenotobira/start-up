-- Delete a buffer without closing its window (or nvim). If the window is
-- showing the buffer being deleted, switch it to another listed buffer first.
local function delete_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local others = vim.tbl_filter(function(buf)
    return buf ~= bufnr and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #others > 0 then
    -- Point any window currently displaying this buffer at another buffer
    -- so the window stays open after the delete.
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == bufnr then
        vim.api.nvim_win_set_buf(win, others[1])
      end
    end
  end

  vim.api.nvim_buf_delete(bufnr, {})
end

require("bufferline").setup({
  options = {
    mode = "buffers",

    close_command = delete_buffer,
    right_mouse_command = delete_buffer,

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
  delete_buffer()
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
