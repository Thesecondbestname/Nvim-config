return {

  {
    "nvim-lua/plenary.nvim",
    -- module = true,
    lazy = true,
  },

  {
    "moll/vim-bbye",
  },

  {
    "dstein64/vim-startuptime",
    init = function()
      vim.g.startuptime_tries = 5
    end,
    cmd = "StartupTime",
    dependencies = {
      "nvim-lualine/lualine.nvim", -- Just to fix stuck issue on vim-startuptime
    },
  },
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
            {"nvim-lua/popup.nvim"},
            {"nvim-lua/plenary.nvim"},
         }
   }
}
