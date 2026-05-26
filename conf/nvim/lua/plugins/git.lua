require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },

  current_line_blame = false,

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, {
        buffer = bufnr,
        silent = true,
        desc = desc,
      })
    end

    map("]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next git hunk")

    map("[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Previous git hunk")

    map("gh", gs.preview_hunk, "Preview hunk")
    map("gb", gs.blame_line, "Blame line")
  end,
})
