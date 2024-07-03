return {
  '00sapo/visual.nvim',
    opts =
    require("plugins.configs.visual")
    ,
   dependencies = { "nvim-treesitter", "nvim-treesitter-textobjects" }, -- this is needed so that visual.nvim is loaded *afterwards* Treesitter 
  event = "VeryLazy"
}
