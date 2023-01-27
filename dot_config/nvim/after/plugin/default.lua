---@diagnostic disable: undefined-global
vim.cmd([[colorscheme base16-railscasts]])

vim.keymap.set("n", "Q", "@")

vim.keymap.set('n', '<leader>fs', "w", { desc = '[F]ile [S]ave' })
vim.keymap.set('n', '<leader>fw', ":%s/\\s\\+$//<CR>:let @/=''<CR>", { desc = '[F]ile [W]hitespace' })
vim.keymap.set('v', '<leader>fw', ":'<,'>s/\\s\\+$//<CR>:let @/=''<CR>", { desc = '[F]ile [W]hitespace' })

vim.keymap.set('n', '<leader>ss', require('telescope.builtin').current_buffer_fuzzy_find,
    { desc = '[S]earch in current buffer ([S]ceen maybe?)' })
