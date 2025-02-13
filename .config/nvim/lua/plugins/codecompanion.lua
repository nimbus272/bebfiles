return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "ollama_deepseek",
      },
    },
    adapters = {
      ollama_deepseek = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "ollama_deepseek",
          schema = {
            model = {
              default = "qwen2.5-coder:32b",
            },
          },
        })
      end,
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
