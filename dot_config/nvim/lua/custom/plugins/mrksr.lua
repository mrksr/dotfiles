---@diagnostic disable: undefined-global
return {
    {
        "RRethy/nvim-base16",
        lazy = false,
        config = function ()
            if not vim.g.vscode then
                vim.cmd.colorscheme "base16-railscasts"
            end
        end
    },
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    },
    "machakann/vim-sandwich",
    "svermeulen/vim-cutlass"
}
