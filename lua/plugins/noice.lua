return({
  "folke/noice.nvim",
  config = function()
    require("notify").setup({
      background_colour = "#2b3040",
    })
    require("noice").setup({
         lsp = {
           signature = { enabled = false},
           hover = { enabled = false},
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = false,
      ["config.lsp.hover.enabled"] = false,
    },
  },

  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    }
})
