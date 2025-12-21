---@diagnostic disable: undefined-global
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		config = function()
			if not vim.g.vscode then
				vim.cmd.colorscheme("kanagawa")
			end
		end,
	},
	{
		"folke/which-key.nvim",
		ops = {},
	},
	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
		end,
	},
	"machakann/vim-sandwich",
	"svermeulen/vim-cutlass",
	"isobit/vim-caddyfile",
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = { "icon", "size", "mtime" },
			view_options = { show_hidden = true },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
	},
	{
		"https://codeberg.org/esensar/nvim-dev-container",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
}
