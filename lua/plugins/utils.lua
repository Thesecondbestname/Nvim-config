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
    "terrortylor/nvim-comment",
  config = function() 
      require("nvim_comment").setup({  comment_empty = true,})
    end
  },
}
