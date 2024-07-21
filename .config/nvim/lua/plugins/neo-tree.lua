return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },
}
