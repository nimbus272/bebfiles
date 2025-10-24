return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>os",
      function()
        Snacks.picker.files({
          finder = "files",
          format = "file",
          show_empty = true,
          hidden = false,
          dirs = {
            "/home/bebbis/Documents/BebNotes/BebNotes",
          },
        })
      end,
    },
    {
      "<leader>oz",
      function()
        Snacks.picker.grep({
          finder = "grep",
          format = "file",
          show_empty = true,
          live = true,
          supports_live = true,
          dirs = {
            "/home/bebbis/Documents/BebNotes/BebNotes",
          },
        })
      end,
    },
  },
  opts = {
    explorer = {
      replace_netrw = false,
    },
    ---@class snacks.dashboard.Config
    dashboard = {
      sections = {
        {
          pane = 2,
          {
            section = "terminal",
            cmd = "jp2a --colors ~/Pictures/smaller-mask.png; sleep .1",
            height = 35,
            indent = 2,
          },
        },
        {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
    picker = {
      sources = {
        explorer = {
          follow_file = false,
          auto_close = true,
          hidden = true,
        },
        files = { hidden = true },
        grep = { hidden = true },
      },
    },
  },
}
