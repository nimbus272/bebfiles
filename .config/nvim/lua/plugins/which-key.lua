return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>o", desc = "+obsidian", mode = { "x", "n" } },
      { "<leader>ot", desc = "New Note From Template To Inbox", mode = { "x", "n" } },
      { "<leader>oo", desc = "Change To Vault Directory", mode = { "x", "n" } },
      { "<leader>on", desc = "New Blank Note To Inbox", mode = { "x", "n" } },
      { "<leader>oc", desc = "Context Action (toggle checkboxes, follow links, etc...)", mode = { "x", "n" } },
      { "<leader>os", desc = "Search Files In Obsidian Vault", mode = { "x", "n" } },
      { "<leader>oz", desc = "Search Text In Obsidian Vault", mode = { "x", "n" } },
      { "<leader>y", desc = "+yazi", mode = { "x", "n" } },
      { "<leader>yf", desc = "Open Yazi at Current File", mode = { "x", "n" } },
      { "<leader>yc", desc = "Open Yazi at Current Neovim Working Director", mode = { "x", "n" } },
      { "<leader>yy", desc = "Reopen Last Yazi Session", mode = { "x", "n" } },
      { "gb", desc = "Go Back", mode = { "x", "n" } },
      { "kj", desc = "Escape Insert Mode", mode = "i" },
    },
  },
}
