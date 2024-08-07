return {
  "folke/which-key.nvim",
  module = true,
  cmd = "WhichKey",
  keys = "<leader>",
  config = function()
    local which_key = require "which-key"

    local setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g

        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 0, 2, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", ":", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }

    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local function toggleAlpha()
      if vim.bo.buftype == "" or vim.bo.filetype == "alpha" or vim.bo.filetype == "checkhealth" then
        vim.cmd ":Alpha"
      end
    end

    local mappings = {
      ["a"] = { toggleAlpha, "Alpha" },
      ["e"] = { ":NvimTreeToggle<cr>", "Explorer" },
      ["q"] = { ":qa!<cr>", "Quit" },
      ["f"] = {
        ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Search files",
      },
      ["s"] = { ":write<cr>", "Safe file"},
      ["x"] = { ":Bdelete!<cr>", "Close Buffer" },
      ["h"] = { ":Cheatsheet<cr>", "Command Help"},
      ["H"] = { ":require(\"lsp_lines\").toggle, { desc = \"Toggle lsp_lines\" } <cr>", "Toggle hints"},
      z = {
        name = "Zen mode",
        a = {":TZAtaraxis<cr>", "Inner peace"},
        m = {"<cmd>TZMinimalist<cr><cmd>Twilight<cr>", "Code like you never did before"},
      },
      p = {
        name = "Plugin",
        c = { ":Lazy clean<cr>", "Clean" },
        C = { ":Lazy check<cr>", "Check" },
        d = { ":Lazy debug<cr>", "Debug" },
        i = { ":Lazy install<cr>", "Install" },
        s = { ":Lazy sync<cr>", "Sync" },
        l = { ":Lazy log<cr>", "Log" },
        h = { ":Lazy home<cr>", "Home" },
        H = { ":Lazy help<cr>", "Help" },
        p = { ":Lazy profile<cr>", "Profile" },
        u = { ":Lazy update<cr>", "Update" },
      },
      n = {
        name = "Neovim",
        r = { ":Reload<cr>", "Core Reload " },
        t = { "<cmd>Lazy reload visual.nvim<cr><cmd>Lazy reload which-key.nvim<cr>", "reload problemmaker plugins" },
        c = { ":e $MYVIMRC<cr>", "Configuration" },
        i = { ":Inspect<cr>", "Inspect" }, -- only available on neovim 0.9
        u = { ":Update<cr>", "Update" },
        h = { ":checkhealth<cr>", "Health" },
        v = { ":version<cr>", "Version" },
      },
      g = {
        name = "Git",
        g = {
          function()
            local Terminal = require("toggleterm.terminal").Terminal
            local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
            lazygit:toggle()
          end,
          "Lazygit",
        },
        j = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
          ":lua require 'gitsigns'.undo_stage_hunk()<cr>",
          "Undo Stage Hunk",
        },
        o = { ":Telescope git_status<cr>", "Open changed file" },
        b = { ":Telescope git_branches<cr>", "Checkout branch" },
        c = { ":Telescope git_commits<cr>", "Checkout commit" },
        d = {
          ":Gitsigns diffthis HEAD<cr>",
          "Diff",
        },
      },
      l = {
        name = "LSP",
        f = { ":Format<cr>", "Format" },
        a = { vim.cmd.RustLsp('codeAction'), "Code Action" },
        i = { ":LspInfo<cr>", "Info" },
        o = { ":Lspsaga outline<cr>", "Code Outline" },
        I = { ":Lspsaga incoming_calls<cr>", "Incoming Calls" },
        O = { ":Lspsaga outgoing_calls<cr>", "Outgoing Calls" },
        j = {
          ":Lspsaga diagnostic_jump_next<cr>",
          "Next Diagnostic",
        },
        k = {
          vim.lsp.buf.hover(),
          "Hover action",
        },
        r = { ":Lspsaga rename<cr>", "Rename" },
        R = { ":LspRestart<cr>", "Restart lsp" },
        t = {  "<cmd>TodoTelescope<cr>", desc = "Todo" },
        d = { ":Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        D = { ":Telescope diagnostics<cr>", "Workspace Diagnostics" },
        s = { ":Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = { ":Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" },
        m = { ":Mason<cr>", "Mason Installer" },
     },
      d = {
        name = "Dap",
        c = { ":lua require'dap'.continue()<cr>", "Continue" },
        o = { ":lua require'dap'.step_over()<cr>", "Step Over" },
        i = { ":lua require'dap'.step_into()<cr>", "Step Into" },
        u = { ":lua require'dap'.step_out()<cr>", "Step Out" },
        b = { ":lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        d = { ":lua require'dapui'.toggle()<cr>", "Dap UI" },
      },
      t = {
        name = "Telescope",
        a = { ":Telescope autocommands<cr>", "Autocommmands" },
        b = { ":Telescope git_branches<cr>", "Checkout branch" },
        c = { ":Telescope colorscheme<cr>", "Colorscheme" },
        h = { ":Telescope help_tags<cr>", "Find Help" },
        k = { ":Telescope keymaps<cr>", "Keymaps" },
        C = { ":Telescope commands<cr>", "Commands" },
        r = { ":Telescope oldfiles<cr>", "Recent File" },
        H = { ":Telescope highlights<cr>", "Highlights" },
        t = { ":Telescope<cr>", "Just the telescope"}
      },
      T = {
        name = "Terminal",
        f = { ":ToggleTerm direction=float<cr>", "Float" },
        h = { ":ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { ":ToggleTerm size=50 direction=vertical<cr>", "Vertical" },
      },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
  end,
}
