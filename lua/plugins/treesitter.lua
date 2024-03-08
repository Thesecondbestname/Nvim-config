return {
	"nvim-treesitter/nvim-treesitter",
	module = true,
	event = { "BufReadPost", "BufNewFile" },
	cmd = {
		"TSInstall",
		"TSInstallInfo",
		"TSUpdate",
		"TSBufEnable",
		"TSBufDisable",
		"TSEnable",
		"TSDisable",
		"TSModuleInfo",
	},
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			config = function()
				local indent_blankline = require("ibl")

				indent_blankline.setup(
					{
						indent = {char = "▏"},
						exclude = { buftypes = { "terminal", "nofile" },
							filetypes = {
								"help",
								"NvimTree",
							}, }
					})
			end,
		},
	},
	build = ":TSUpdate",
	config = function()
		local configs = require "nvim-treesitter.configs"

		configs.setup {
			ensure_installed = { "cpp", "lua", "c", "go", "python", "java" ,"rust"}, -- one of "all" or a list of languages
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = "", -- list of language that will be disabled
			},
			autopairs = {
				enable = true,
			},
			indent = { enable = false, disable = {} },
		}
	end,
}
