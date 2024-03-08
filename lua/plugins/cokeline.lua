return {
	"noib3/nvim-cokeline",
	dependencies = 'nvim-tree/nvim-web-devicons', -- If you want devicons
	config = function()
		require('cokeline').setup(
			{
				default_hl = {
					fg = function(buffer)
						return
						    buffer.is_focused
						    and require("cokeline/utils").get_hex('Normal', 'fg')
						    or require("cokeline/utils").get_hex('Comment', 'fg')
					end,
					bg = function(buffer)
						if buffer.is_focused then
							return "#eba0ac"
						else
							return "#2a2c3f"
						end
					end
				},
				sidebar = {
					filetype = { 'NvimTree', 'neo-tree' },
					components = {
						{
							text = function(buf)
								return buf.filetype
							end,
							bold = true,
						},
					}
				},
				components = {
					{
						text = ' ',
						bg = require("cokeline/utils").get_hex('Normal', 'bg'),
					},
					{
						text = '',
						fg = function(buffer)
							if buffer.is_focused then
								return "#eba0ac"
							else
								return "#2a2c3f"
							end
						end,
						bg = require("cokeline/utils").get_hex('Normal', 'fg'),
					},
					{
						text = function(buffer)
							return buffer.devicon.icon
						end,
						fg = function(buffer)
							if not buffer.is_focused then
								return buffer.devicon.color
							else
								return "#181825"
							end
						end,
					},
					{
						text = ' ',
					},
					{
						text = function(buffer) return buffer.filename .. '  ' end,
						style = function(buffer)
							return buffer.is_focused and 'bold' or nil
						end,
						fg = function(buffer)
							if buffer.is_focused then
								return "#181825"
							else
								return "#cdd6f4"
							end
						end,
					},
					{
						text = '',
						delete_buffer_on_left_click = true,
						fg = function(buffer)
							if buffer.is_focused then
								return "#181825"
							else
								return "#cdd6f4"
							end
						end,
					},
					{
						text = '',
						fg = function(buffer)
							if buffer.is_focused then
								return "#eba0ac"
							else
								return "#2a2c3f"
							end
						end,
						bg = require("cokeline/utils").get_hex('Normal', 'fg'),
					},
				},
			})
	end
}
