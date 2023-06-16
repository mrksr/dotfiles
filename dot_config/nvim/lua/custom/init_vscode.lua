---@diagnostic disable: undefined-global
--
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    },
    "machakann/vim-sandwich",
    "svermeulen/vim-cutlass"
}, {})

-- From kickstart.nvim
vim.o.undofile = true
vim.o.updatetime = 250

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "Q", "@")
vim.keymap.set({ "n", "x" }, "m", "d")
vim.keymap.set("n", "mm", "dd")
vim.keymap.set("n", "M", "D")

-- Specific for vscode
local nmap = function(keys, func)
    vim.keymap.set('n', keys, func, { silent = true, remap = false })
end
-- Editing
nmap("j", "<Cmd>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>")
nmap("k", "<Cmd>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>")

-- File Manipulation
nmap("<leader>fs", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")

-- Project navigation
nmap("<leader>ff", "<Cmd>Find<CR>")
nmap("<leader>pf", "<Cmd>Find<CR>")

nmap("<leader>ps", "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>")
nmap("<leader>pj", "<Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>")


nmap("<leader>bb", "<Cmd>Tabfind<CR>")

nmap("<leader>ss", "<Cmd>call VSCodeNotify('fuzzySearch.activeTextEditor')<CR>")
nmap("<leader>sj", "<Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>")

-- Programming
nmap("<leader>fi", "<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>:<C-u>call VSCodeNotify('editor.action.organizeImports')<CR>")
nmap("<leader>fx", "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")
nmap("<leader>fr", "<Cmd>call VSCodeNotify('editor.action.rename')<CR>")
nmap("K", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>")
nmap("gd", "<Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>")
nmap("gD", "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>")

-- Commenting
vim.keymap.set({"n", "x", "o"}, "gc", "<plug>VSCodeCommentary", { silent = true })
vim.keymap.set("n", "gcc", "<plug>VSCodeCommentaryLine", { silent = true })
