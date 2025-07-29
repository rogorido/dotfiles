-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Remap 'v' to Visual Line mode
-- vim.api.nvim_set_keymap("n", "v", "V", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("x", "v", "V", { noremap = true, silent = true })
--
-- -- Remap 'V' to Visual Character mode
-- vim.api.nvim_set_keymap("n", "V", "v", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("x", "V", "v", { noremap = true, silent = true })
--
-- Remap 'Ctrl-m' to start and stop recording macros
--  por qué no funciona esto?
vim.api.nvim_set_keymap("n", "<C-m>", "q", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-m>", "q", { noremap = true, silent = true })

-- Optionally, disable 'q'
-- cuidado con esto: no tiene otros efectos?
vim.api.nvim_set_keymap("n", "q", "<nop>", { noremap = true, silent = true })
