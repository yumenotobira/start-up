require("neo-tree").setup({
  close_if_last_window = true,

  popup_border_style = "rounded",

  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },

    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },

    use_libuv_file_watcher = true,
  },

  window = {
    position = "left",
    width = 32,

    mappings = {
      ["<space>"] = "none",
      ["<cr>"] = "open",
      ["o"] = "open",

      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["t"] = "open_tabnew",

      ["C"] = "close_node",
      ["z"] = "close_all_nodes",

      ["a"] = "add",
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["m"] = "move",
      ["c"] = "copy",

      ["R"] = "refresh",
      ["?"] = "show_help",

      ["<C-f>"] = function()
        vim.cmd("wincmd p")
        require("fzf-lua").files()
      end,

      ["<C-g>"] = function()
        vim.cmd("wincmd p")
        require("fzf-lua").live_grep()
      end,
    },
  },
})
