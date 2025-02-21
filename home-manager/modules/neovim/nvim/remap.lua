vim.g.mapleader = " "

-- Quick-save
-- nmap <leader>w :w<CR>
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- <leader><leader> toggles between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- ctrl c is now esc
vim.keymap.set("i", "<C-c>", "<Esc>")
