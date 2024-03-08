return {
	"karb94/neoscroll.nvim",
	event = "BufEnter",
	config = function()
		require("neoscroll").setup({})
	end,
}
