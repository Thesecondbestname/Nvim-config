return {
  serendipity = {
      highlight = "guibg=#313244 guifg=none"

  },
  nunmaps = {"W", "E", "B", "w", "e", "b", "y" },
  vunmaps = {"x", "U", "u"},
  mappings = {
    -- a list of command names and of their key-maps; what each command does is defined below
    visual_leader = "<leader>",
    command_visual = "C",
    WORD_end_next = "E", -- select next WORD (punctuation included), cursor at end, previous space included
    left = "h",
    right = "l",
    up = "k",
    down = "j",
    undo = "u",
    redo = "U",
    delete = "d",
    docs = "K", -- Open Docs of selected area
    command_visual = ":", -- Open Docs of selected area
    word_end_next = "w", -- same as E but without punctuation
    WORD_end_prev = "gE", -- same as E but for previous words
    word_end_prev = "ge", -- same as e but for previous words
    WORD_start_next = "W", -- select next word including next its space, cursor at beginning, with punctuation
    word_start_next = "e", -- same as W but without punctuation
    WORD_start_prev = "B", -- select previous WORD including its next space, with punctuation, cursor at beginnning
    word_start_prev = "b", -- same as B but without punctuation
    open_below = "o", -- opens a newline underneath the current line
    toggle_serendipity = "<esc>", -- toggle visual mode, here to override possible mappings from other plugins
    find_next = "f", -- select to next char
    find_prev = "F", -- select to previous char
    till_next = "t", -- select till next char
    till_prev = "T", -- select till previous char
    start_line = "gh", -- select to start of line
    start_text = "_", -- select to start of text
    end_line = "gl", -- select to end of line
    append_at_cursor = "a", -- append at cursor position in visual mode
    insert_at_cursor = "i", -- insert at cursor position in visual mode
    sd_change = "c", -- change selection from serendipity mode (avoid clashing with nvim-cmp)
    sd_inside = "I", -- select inside from serendipity mode
    sd_around = "A", -- select around from serendipity mode
    line_visual = "x", -- enter line-visual mode
    restart_visual = ";", -- collapse the visual selection to the char under cursor
    restart_sd = ";", -- collapse the sd selection to the char under cursor
    replace_single_char = "r", -- replace the char under cursor while in visual mode
    surround_change = "zc", -- change chars at the extremes of the selection
    surround_add = "za", -- insert chars at the extremes of the selection
    surround_delete = "zd", -- delete chars at the extremes of the selection
    increase_indent = ">", -- increase indent in visual mode
    decrease_indent = "<", -- decrease indent in visual mode
    increase_indent_sd = ">", -- increase indent in serendipity mode
    decrease_indent_sd = "<", -- decrease indent in serendipity mode
    increase_indent_normal = ">", -- increase indent in normal mode
    decrease_indent_normal = "<", -- decrease indent in normal mode
    repeat_command = "<A-.>", -- repeat the last visual.nvim command
    repeat_edit = "<A-,>", -- repeat the last edit in visual and serendipity mode
    macro = "q", -- same as usual `q` key, but it also disables visual.nvim (see issue https://github.com/00sapo/visual.nvim/issues/7); must be re-enabled via :VisualEnable when finished playing with macros
    goto_definition = "gd", -- go to definition
    z_help = "z",
    g_help = "g",
  },
  commands = {
    comment_line = {
        pre_amend = { { rhs = ":CommentToggle", countable = false } },
        post_amend = {},
        modes = {"v"},
        amend = false
    },
    g_help = {
        pre_amend = { { rhs = "<esc><cmd>WhichKey g<cr>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    z_help = {
        pre_amend = { { rhs = "<esc>z<sdi>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    undo = {
        pre_amend = { { rhs = "<esc><cmd>undo<cr><sdi>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    redo = {
        pre_amend = { { rhs = "<esc><cmd>redo<cr><sdi>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },

  delete = {
       pre_amend = { { rhs = "d<sdi>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    line_visual = {
        pre_amend = { { rhs = "<sdi>V", countable = false } },
        post_amend = {},
        modes = { "n", "sd", "v" },
    },
    visual_leader = {
      pre_amend = { { rhs = "<esc><sde>", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    open_below = {
        pre_amend = { { rhs = "<esc><sde>o", countable = false } },
        post_amend = {},
        modes = { "sd", "v" },
    },
    command_visual = {
        pre_amend = { { rhs = "<sde><esc>:", countable = false } },
        post_amend = {},
        modes = { "sd" },
    },
    up = {
      pre_amend = {
        "<esc>k<sdi>",
      },
      post_amend = {},
      modes = { "sd" },
    },
    right = {
      pre_amend = {
        "<esc>l<sdi>",
      },
      post_amend = {},
      modes = { "sd" },
    },
    left = {
      pre_amend = {
        "<esc>h<sdi>",
      },
      post_amend = {},
      modes = { "sd" },
    },
    down = {
      pre_amend = {
        "<esc>j<sdi>",
      },
      post_amend = {},
      modes = { "sd" },
    },
    docs = {
      pre_amend = {
        "<sde><esc>",
        vim.lsp.buf.hover
      },
      post_amend = {},
      modes = { "sd" },
      amend = false, -- can't use true, because keys feeded to nvim are the mode seen by `K` is visual even after <esc>. Same issue as macros.
      countable = false,
    },
  }
}
