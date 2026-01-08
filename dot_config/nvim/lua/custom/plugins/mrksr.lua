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
		"FluxxField/smart-motion.nvim",
		opts = {
			keys = "fjdksleirughtynm",
			presets = {
				words = true,
				search = true,
			},
			flow_state_timeout_ms = 500,
			disable_dim_background = false,
			history_max_size = 20,
		},
	},
	"xiyaowong/transparent.nvim",
	{
		"gbprod/cutlass.nvim",
		opts = {},
	},
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
