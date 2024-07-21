-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>ot", ":ObsidianTemplate<cr>")
vim.keymap.set("n", "<leader>oo", ":cd /home/bebbis/Documents/BebNotes/BebNotes<cr>")
vim.keymap.set("n", "<leader>on", function()
  local user_input = vim.fn.input("Enter filename: ")
  vim.api.nvim_command(":ObsidianNew " .. user_input)
end)
vim.keymap.set("n", "<leader>os", ':Telescope find_files search_dirs={"/home/bebbis/Documents/BebNotes/BebNotes"}<cr>')
vim.keymap.set("n", "<leader>oz", ':Telescope live_grep search_dirs={"/home/bebbis/Documents/BebNotes/BebNotes"}<cr>')
