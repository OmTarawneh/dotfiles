-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

-- avoid overwriting the default register when you paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- yank the selected text or current line to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- yank the current line to the system clipboard in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete the selected text or current line without affecting the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- J: move selected line(s) down by one
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- K: move selected line(s) up by one
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Enhance 'J' behavior in Normal Mode
vim.keymap.set("n", "J", "mzJ`z")
-- Use 'jk' as an alternative to ESC
vim.keymap.set("i", "jk", "<ESC>")

-- Scroll down half a page and center the cursor vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scroll up half a page and center the cursor vertically
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jump to the next search result, center the cursor, and open folds if necessary
vim.keymap.set("n", "n", "nzzzv")

-- Jump to the previous search result, center the cursor, and open folds if necessary
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<C-H>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-L>", "<C-w>l", { desc = "Move to right window" })
-- vim.keymap.set("n", "<C-J>", "<C-w>j", { desc = "Move to bottom window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })

-- Restart the Language Server Protocol (LSP) client
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- avoid overwriting the default register when you paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- yank the selected text or current line to the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- yank the current line to the system clipboard in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete the selected text or current line without affecting the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable the "Q" key in Normal Mode
-- The `Q` key is normally used for entering Ex mode, which is an old Vim feature.
-- The `"<nop>"` tells Neovim to do nothing when the `Q` key is pressed in Normal Mode, effectively disabling it.
vim.keymap.set("n", "Q", "<nop>")

-- Bind <leader>f to format the current buffer using the LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Replace the word under the cursor with itself (case-insensitive) across the entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable using `chmod +x`
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", "<cmd>source % | echo 'File sourced!'<CR>")

-- Console.log keymaps
-- Insert console.log(what_I_copied) at cursor position
vim.keymap.set("n", "<leader>cpe", function()
  local content = vim.fn.getreg('"')
  if content ~= "" then
    vim.api.nvim_put({ "console.log(" .. content .. ")" }, "", false, true)
  else
    vim.notify("No content in clipboard", vim.log.levels.WARN)
  end
end, { desc = "Insert console.log(what_I_copied)" })

-- Insert console.log({what_I_copied}) at cursor position
vim.keymap.set("n", "<leader>cpo", function()
  local content = vim.fn.getreg('"')
  if content ~= "" then
    vim.api.nvim_put({ "console.log({" .. content .. "})" }, "", false, true)
  else
    vim.notify("No content in clipboard", vim.log.levels.WARN)
  end
end, { desc = "Insert console.log({what_I_copied})" })
