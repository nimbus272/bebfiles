return {
  "folke/snacks.nvim",
  opts = {
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
  },
}
