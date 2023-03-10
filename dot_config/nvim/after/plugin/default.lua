---@diagnostic disable: undefined-global
vim.o.swapfile = false

vim.cmd("com! CD cd %:p:h")
vim.cmd("com! LCD lcd %:p:h")

vim.keymap.set("n", "Q", "@")
vim.keymap.set({ "n", "x" }, "m", "d")
vim.keymap.set("n", "mm", "dd")
vim.keymap.set("n", "M", "D")

vim.keymap.set('n', '<leader>fw', ":%s/\\s\\+$//<CR>:let @/=''<CR>", { desc = '[F]ile [W]hitespace' })
vim.keymap.set('v', '<leader>fw', ":'<,'>s/\\s\\+$//<CR>:let @/=''<CR>", { desc = '[F]ile [W]hitespace' })

if not vim.g.vscode then
    vim.keymap.set('n', '<leader>fs', ":w<CR>", { desc = '[F]ile [S]ave' })
    vim.keymap.set('n', '<leader>ss', require('telescope.builtin').current_buffer_fuzzy_find,
        { desc = '[S]earch in current buffer' })
end
