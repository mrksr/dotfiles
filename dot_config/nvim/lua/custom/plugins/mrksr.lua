---@diagnostic disable: undefined-global
return {
    {
        "chriskempson/base16-vim",
        lazy = false,
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
