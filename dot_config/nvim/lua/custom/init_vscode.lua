---@diagnostic disable: undefined-global
require('packer').startup(function(use)
    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    })
    use("machakann/vim-sandwich")
end)

-- From kickstart.nvim
vim.o.undofile = true
vim.o.updatetime = 250

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Specific for vscode
local nmap = function(keys, func)
    vim.keymap.set('n', keys, func, { silent = true })
end
-- Editing
nmap("j", ":<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>")
nmap("k", ":<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>")

-- File Manipulation
nmap("<leader>fs", ":<C-u>call VSCodeNotify('workbench.action.files.save')<CR>")

-- Project navigation
nmap("<leader>ff", ":<C-u>Find<CR>")
nmap("<leader>pf", ":<C-u>Find<CR>")

nmap("<leader>ps", ":<C-u>call VSCodeNotify('workbench.action.findInFiles')<CR>")
nmap("<leader>pj", ":<C-u>call VSCodeNotify('workbench.action.showAllSymbols')<CR>")


nmap("<leader>bb", ":<C-u>Tabfind<CR>")

nmap("<leader>ss", ":<C-u>call VSCodeNotify('fuzzySearch.activeTextEditor')<CR>")
nmap("<leader>sj", ":<C-u>call VSCodeNotify('workbench.action.gotoSymbol')<CR>")

-- Programming
nmap("<leader>fi", ":<C-u>call VSCodeNotify('editor.action.formatDocument')<CR>:<C-u>call VSCodeNotify('editor.action.organizeImports')<CR>")
nmap("<leader>fx", ":<C-u>call VSCodeNotify('editor.action.quickFix')<CR>")
nmap("<leader>fr", ":<C-u>call VSCodeNotify('editor.action.rename')<CR>")
nmap("K", ":<C-u>call VSCodeNotify('editor.action.showHover')<CR>")
nmap("gd", ":<C-u>call VSCodeNotify('editor.action.peekDefinition')<CR>")
nmap("gD", ":<C-u>call VSCodeNotify('editor.action.revealDefinition')<CR>")

-- Commenting
vim.keymap.set({"n", "x", "o"}, "gc", "<plug>VSCodeCommentary", { silent = true })
vim.keymap.set("n", "gcc", "<plug>VSCodeCommentaryLine", { silent = true })
