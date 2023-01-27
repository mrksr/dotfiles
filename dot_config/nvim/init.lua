---@diagnostic disable: undefined-global
if vim.g.vscode then
    require('custom.init_vscode')
else
    require('custom.init_nvim')
end
