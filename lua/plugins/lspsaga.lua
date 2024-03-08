return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  config = function ()
	require("lspsaga").setup({
		lightbulb = {
			enabled = false
		},
		symbol_in_winbar = {
		    enable = false
		}
	})
  end,
}
