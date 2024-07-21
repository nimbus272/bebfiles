return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "go",
      "gomod",
      "gowork",
      "gosum",
      "markdown",
      "markdown_inline",
    })
  end,
}
