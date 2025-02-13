return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        kitty = true,
      })
    end,
  },
}
