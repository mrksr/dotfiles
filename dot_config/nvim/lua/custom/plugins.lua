return function(use)
    use("chriskempson/base16-vim")

    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end
    })

    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    })
    use("machakann/vim-sandwich")

    use("edkolev/tmuxline.vim")
end
