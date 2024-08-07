local present, alpha = pcall(require, "alpha")

if not present then
	return
end

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 36,
		align_shortcut = "right",
		hl = "AlphaButtons",
	}

	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.1
local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })
local val = {
	"  ▄▄▄▄▄  ▄ .█ ▄▄▄▄ .                                                                        ",
	"  •██   ██▪▐█ ▀▄.▀·                                                                       ",
	"   ▐█.▪ ██▀▐█ ▐▀▀▪▄                                                                         ",
	"   ▐█▌· ██▌▐▀ ▐█▄▄▌                                                                         ",
	"   ▀▀▀  ▀▀  ·  ▀▀▀                                                                          ",
	"       ▄▄·  ▄▄▄·▄▄▄▄▄ ▄▄▄· ▄▄▄· ▄• ▄▌ ▄▄·  ▄▄· ▪    ▐   ▄      ▄▄·        ▐ ▄ ·▄▄▄ ▪   ▄▄ • ",
	"      ▐█ ▌▪▐█ ▀█•██  ▐█ ▄█▐█ ▄█ █▪██▌▐█ ▌▪▐█ ▌▪██  •██ ▐█    ▐█ ▌▪▪     •█▌▐█ ▐▄▄· ██ ▐█ ▀ ▪",
	"      ██ ▄▄▄█▀▀█ ▐█.▪ ██▀· ██▀· █▌▐█▌██ ▄▄██ ▄▄▐█· ▐█ █▐▌    ██ ▄▄ ▄█▀▄ ▐█▐▐▌ ██▪  ▐█·▄█ ▀█▄",
	"      ▐███▌▐█ ▪▐▌▐█▌·▐█▪·•▐█▪·• ▐█▄█▌▐███▌▐███▌▐█▌ ██ ▐█▌    ▐███▌▐█▌.▐▌██▐█▌ ██▌. ▐█▌▐█▄▪▐█",
	"      ·▀▀▀  ▀  ▀ ▀▀▀ .▀   .▀     ▀▀▀ ·▀▀▀ ·▀▀▀ ▀▀▀ ▀▀  █▪    ·▀▀▀  ▀█▄▀▪▀▀ █▪ ▀▀▀  ▀▀▀·▀▀▀▀ ",
}
-- Make the header a bit more fun with some color!
local function colorize_header()
	local catppuccin = require("catppuccin.palettes").get_palette()
	local colors = {
		catppuccin.pink,
		catppuccin.mauve,
		catppuccin.red,
		catppuccin.maroon,
		catppuccin.peach,
		catppuccin.yellow,
		catppuccin.green,
		catppuccin.sky,
		catppuccin.sapphire,
		catppuccin.blue,
	}
	for i, color in pairs(colors) do
		local cmd = "hi StartLogo" .. i .. " guifg=" .. color
		vim.cmd(cmd)
	end

	local lines = {}

	for i, chars in pairs(val) do
		local line = {
			type = "text",
			val = chars,
			opts = {
				hl = "StartLogo" .. i,
				shrink_margin = false,
				position = "center",
			},
		}

		table.insert(lines, line)
	end

	return lines
end
local options = {

	header = {type= "group", val = colorize_header()},
	buttons = {
		type = "group",
		val = {
			button("Space f", "  Find File  ", ":Telescope find_files<CR>"),
			button("SPC s r", "  Recent File  ", ":Telescope oldfiles<CR>"),
			button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
			button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
			button("SPC e s", "  Configs", ":e $MYVIMRC | :cd %:p:h <CR>"),
			button("SPC p i", "  Plugins", ":Lazy <CR>"),
			button("SPC t q", "  Quit  ", ":qa<CR>"),
		},
		opts = {
			spacing = 1,
		},
	},

	headerPaddingTop = { type = "padding", val = headerPadding },
	headerPaddingBottom = { type = "padding", val = 2 },
}

alpha.setup({
	layout = {
		options.headerPaddingTop,
		options.header,
		options.headerPaddingBottom,
		options.buttons,
	},
	opts = {},
})

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		-- store current statusline value and use that
		local old_laststatus = vim.opt.laststatus
		vim.api.nvim_create_autocmd("BufUnload", {
			buffer = 0,
			callback = function()
				vim.opt.laststatus = old_laststatus
			end,
		})
		vim.opt.laststatus = 0
	end,
})
