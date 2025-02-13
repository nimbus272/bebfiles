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
      { "gb", desc = "Go Back", mode = { "x", "n" } },
      { "kj", desc = "Escape Insert Mode", mode = "i" },
    },
  },
}
