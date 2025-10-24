-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Obsidian Keymaps
-- Also has <leader>oc as a context action defined in plugins/obsidian.lua
vim.keymap.set("n", "<leader>ot", ":ObsidianNewFromTemplate<cr>")
vim.keymap.set("n", "<leader>oo", ":cd /home/bebbis/Documents/BebNotes/BebNotes<cr>")
vim.keymap.set("n", "<leader>on", function()
  local user_input = vim.fn.input("Enter filename: ")
  vim.api.nvim_command(":ObsidianNew " .. user_input)
end)

--Normal Custom Remaps
vim.keymap.set("n", "gb", "<c-o>")
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")

-- smart splits ---
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
