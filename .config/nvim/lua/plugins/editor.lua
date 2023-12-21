return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      local tree = require("nvim-tree")

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        -- api.config.mappings.default_on_attach(bufnr)

        local function add_key(mode, new, func, desc)
          vim.keymap.set(mode, new, func, opts(desc))
        end

        -- local function del_key(mode, old)
        --   vim.keymap.del(mode, old, { buffer = bufnr })
        -- end
        --
        -- local function replace_key(mode, old, new, func, desc)
        --   del_key(mode, old)
        --   add_key(mode, new, func, desc)
        -- end

        -- custom mappings
        add_key("n", "?", api.tree.toggle_help, "Show helps")
        add_key("n", "<s-left>", api.tree.change_root_to_parent, "Up")
        add_key("n", "<s-right>", api.tree.change_root_to_node, "Cd")
        add_key("n", "gm", api.tree.toggle_git_clean_filter, "Toggle git modified")
        add_key("n", "gi", api.tree.toggle_gitignore_filter, "Toggle git ignored")
        add_key("n", "e", api.tree.expand_all, "Expand all")
        add_key("n", "w", api.tree.collapse_all, "Collapse all")
        add_key("n", "q", api.tree.close, "Quit")
        add_key("n", "R", api.tree.reload, "Refresh")
        add_key("n", "S", api.tree.search_node, "Search")
        add_key("n", "H", api.tree.toggle_hidden_filter, "Toggle hidden")
        add_key("n", "B", api.tree.toggle_no_buffer_filter, "Toggle buffers")
        add_key("n", "U", api.tree.toggle_custom_filter, "Toggle custom filter")

        add_key("n", "<cr>", api.node.open.edit, "Open")
        add_key("n", "<tab>", api.node.open.preview, "Preview")
        add_key("n", "<right>", api.node.open.preview, "Preview")
        add_key("n", "<left>", api.node.navigate.parent, "Goto parent")
        add_key("n", "<bs>", api.node.navigate.parent_close, "Close Dir")
        add_key("n", "i", api.node.show_info_popup, "Show info")
        add_key("n", "o", api.node.open.replace_tree_buffer, "Open in place")
        add_key("n", "t", api.node.open.tab, "Open in new tab")
        add_key("n", "v", api.node.open.vertical, "Open vertically")
        add_key("n", "h", api.node.open.horizontal, "Open horizontally")
        add_key("n", "<", api.node.navigate.sibling.prev, "Prev sibling")
        add_key("n", ">", api.node.navigate.sibling.next, "Next sibling")
        add_key("n", "[c", api.node.navigate.git.prev, "Prev git")
        add_key("n", "]c", api.node.navigate.git.next, "Next git")
        add_key("n", "[e", api.node.navigate.diagnostics.prev, "Prev diagnostic")
        add_key("n", "]e", api.node.navigate.diagnostics.next, "Next diagnostic")
        add_key("n", "k", api.node.navigate.sibling.first, "First sibling")
        add_key("n", "j", api.node.navigate.sibling.last, "Last sibling")
        add_key("n", "O", api.node.run.system, "Open with vscode")
        add_key("n", ".", api.node.run.cmd, "Run command")

        add_key("n", "n", api.fs.create, "New")
        add_key("n", "c", api.fs.copy.node, "Copy")
        add_key("n", "gp", api.fs.copy.absolute_path, "Copy absolute path")
        add_key("n", "gr", api.fs.copy.relative_path, "Copy relative path")
        add_key("n", "gf", api.fs.copy.filename, "Copy file name")
        add_key("n", "r", api.fs.rename, "Rename")
        add_key("n", "b", api.fs.rename_basename, "Rename base")
        add_key("n", "x", api.fs.cut, "Cut")
        add_key("n", "p", api.fs.paste, "Paste")
        add_key("n", "D", api.fs.remove, "Delete")
        add_key("n", "T", api.fs.trash, "Trash")
        add_key("n", "X", api.fs.clear_clipboard, "Clear clipboard")

        add_key("n", "md", api.marks.bulk.delete, "Delete bookmarked")
        add_key("n", "mt", api.marks.bulk.trash, "Trash bookmarked")
        add_key("n", "mv", api.marks.bulk.move, "Move bookmarked")
        add_key("n", "mm", api.marks.toggle, "Toggle bookmark")

        add_key("n", "gg", api.git.reload, "Git reload")

        -- add_key("n", "F", api.live_filter.clear, "Clean Filter")
        -- add_key("n", "f", api.live_filter.start, "Filter")
      end
      tree.setup({
        on_attach = my_on_attach,
        view = {
          signcolumn = "no",
          width = {
            min = 20,
            max = 30,
            padding = 0,
          },
          float = {
            enable = false,
          },
        },
        renderer = {
          full_name = true,
          root_folder_label = ":~:s?$?",
          highlight_opened_files = "icon",
          highlight_modified = "name",
          indent_markers = {
            enable = true,
          },
        },
        update_focused_file = {
          enable = true,
        },
        system_open = {
          cmd = "code",
        },
        actions = {
          expand_all = {
            exclude = { ".git", ".vscode", ".idea" },
          },
          open_file = {
            window_picker = {
              enable = true,
              -- picker = window_picker,
              chars = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890",
              exclude = {
                filetype = {
                  "notify",
                  "NvimTree",
                  "neo-tree",
                  "neo-tree-popup",
                  "packer",
                  "qf",
                  "diff",
                  "fugitive",
                  "fugitiveblame",
                },
                buftype = {
                  "nofile",
                  "terminal",
                  "help",
                },
              },
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus" },
      { "<leader>eg", "<cmd>lua require('nvim-tree.api').git.reload()<cr>", desc = "Git reload" },
      { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle" },
      { "<leader>ec", "<cmd>NvimTreeClipboard<cr>", desc = "Show clipboard" },
      { "<leader>ex", "<cmd>lua require('nvim-tree.api').fs.clear_clipboard()<cr>", desc = "Clear clipboard" },
      { "<localleader>e", "<leader>ef", desc = "Explorer focus", remap = true },
      { "<localleader><localleader>", "<leader>ee", desc = "Explorer toggle", remap = true },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>e"] = { name = "+explorer" }
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = function()
      -- stylua: ignore
      return {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }
      }
    end,
    config = function()
      require("flash").setup({
        modes = {
          char = {
            keys = { "s", "S" },
          },
        },
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "f", function() require("hop").hint_char1() end, remap = true },
      { "F", function() require("hop").hint_char2() end, remap = true },
      { "L", function() require("hop").hint_lines_skip_whitespace() end, remap = true },
      { "P", function() require("hop").hint_patterns() end, remap = true },
    },
    config = function()
      local positions = require("hop.hint").HintPosition
      require("hop").setup({ hint_position = positions.END })
    end,
  },

  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<localleader>x", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<localleader>X", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  {
    "folke/todo-comments.nvim",
    -- stylua: ignore
    keys = {
      { "<localleader>t", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<localleader>T", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
  },

  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    opts = {
      highlight = {
        underline = false,
        bg = "#445566",
      },
    },
    config = true,
  },

  {
    "LukasPietzschmann/telescope-tabs",
    opts = {},
    keys = {
      {
        "<localleader><tab>",
        "<cmd>lua require('telescope-tabs').list_tabs()<cr>",
        desc = "List tabs",
      },
      {
        "<leader>s<tab>",
        "<cmd>lua require('telescope-tabs').list_tabs()<cr>",
        desc = "Tabs",
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.defaults["<leader>h"] = { name = "+helper" }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}
      opts.defaults.layout_config = opts.defaults.layout_config or {}
      opts.defaults.layout_config.vertical = { width = 0.6, height = 0.6 }
      opts.defaults.layout_strategy = "vertical"
      -- opts.defaults.mappings = { i = {}, n = {} }
      opts.pickers = opts.pickers or {}

      local actions = require("telescope.actions")
      local remap_action = function(key, value, ...)
        local mode = { ... }
        for _, m in ipairs(mode) do
          if m == "i" then
            opts.defaults.mappings.i[key] = value
          elseif m == "n" then
            opts.defaults.mappings.n[key] = value
          end
        end
      end
      local lazyvimUtil = require("lazyvim.util")

      local find_files_no_ignore = function()
        local is_enabled = vim.g.telescope_find_files_no_ignore
        if is_enabled == false or is_enabled == nil then
          is_enabled = true
          vim.g.telescope_find_files_no_ignore = true
        else
          is_enabled = false
          vim.g.telescope_find_files_no_ignore = false
        end

        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        lazyvimUtil.telescope("find_files", { no_ignore = is_enabled, default_text = line })()
      end
      local find_files_with_hidden = function()
        local is_enabled = vim.g.telescope_find_files_with_hidden
        if is_enabled == false or is_enabled == nil then
          is_enabled = true
          vim.g.telescope_find_files_with_hidden = true
        else
          is_enabled = false
          vim.g.telescope_find_files_with_hidden = false
        end

        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        lazyvimUtil.telescope("find_files", { hidden = is_enabled, default_text = line })()
      end

      remap_action("<c-n>", false, "i", "n")
      remap_action("<c-p>", false, "i", "n")
      remap_action("<c-u>", false, "i", "n")
      remap_action("<c-d>", false, "i", "n")
      remap_action("<c-f>", false, "i", "n")
      remap_action("<c-k>", false, "i", "n")
      remap_action("<m-f>", false, "i", "n")
      remap_action("<m-k>", false, "i", "n")
      remap_action("<m-q>", false, "i", "n")
      remap_action("<c-q>", false, "i", "n")
      remap_action("<c-b>", false, "i")
      remap_action("<a-h>", false, "i")
      remap_action("<a-i>", false, "i")
      remap_action("<a-t>", false, "i")
      remap_action("H", false, "n")
      remap_action("L", false, "n")
      remap_action("M", false, "n")

      remap_action("<c-t>", actions.select_tab, "i", "n")
      remap_action("<c-h>", actions.preview_scrolling_left, "i", "n")
      remap_action("<c-l>", actions.preview_scrolling_right, "i", "n")
      remap_action("<c-j>", actions.preview_scrolling_up, "i", "n")
      remap_action("<c-k>", actions.preview_scrolling_down, "i", "n")
      remap_action("<c-i>", find_files_no_ignore, "i", "n")
      remap_action("<c-d>", find_files_with_hidden, "i", "n")
      remap_action("<c-up>", actions.cycle_history_next, "i", "n")
      remap_action("<c-down>", actions.cycle_history_prev, "i", "n")
      remap_action("<c-space>", actions.which_key, "i", "n")
      remap_action("t", actions.select_tab, "n")
      remap_action("h", actions.preview_scrolling_left, "n")
      remap_action("l", actions.preview_scrolling_right, "n")
      remap_action("j", actions.preview_scrolling_up, "n")
      remap_action("k", actions.preview_scrolling_down, "n")
      remap_action("x", actions.select_vertical, "n")
      remap_action("v", actions.select_horizontal, "n")
      remap_action("q", actions.close, "n")

      -- stylua: ignore
      local dropdown_pickers = {
        -- "buffers", "live_grep", "find_files", "oldfiles", "git_files", "git_commits", "git_status",
        -- "current_buffer_fuzzy_find", "diagnostics", "grep_string", "lsp_document_symbols",
        -- "lsp_dynamic_workspace_symbols", "lsp_references",
        -- "command_history", "registers", "autocommands", "commands", "help_tags", "highlights",
        -- "keymaps", "colorscheme", "vim_options",
      }
      for _, value in pairs(dropdown_pickers) do
        opts.pickers[value] = { theme = "dropdown" }
      end

      local cursor_pickers = { "lsp_definitions", "lsp_type_definitions" }
      for _, value in pairs(cursor_pickers) do
        opts.pickers[value] = { theme = "cursor" }
      end
    end,
    keys = function()
      local lazyvimUtil = require("lazyvim.util")
      local lazyvimConfig = require("lazyvim.config")
      local builtin = require("telescope.builtin")
      local utils = require("telescope.utils")
      -- stylua: ignore
      return {
        { "<leader>,", function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end, desc = "Buffers" },
        { "<leader>/", function() builtin.live_grep() end, desc = "Grep (workspace)" },
        { "<leader>;", function() builtin.command_history() end, desc = "Command History" },
        { "<leader><space>", function() builtin.find_files() end, desc = "Find Files (workspace)" },
        -- files
        { "<leader>fb", function() builtin.buffers({ sort_mru = true, sort_lastused = true }) end, desc = "Buffers" },
        { "<leader>fc", function() lazyvimUtil.telescope.config_files() end, desc = "Find Config File" },
        { "<leader>ff", function() builtin.find_files() end, desc = "Find Files (workspace)" },
        { "<leader>fF", function() builtin.find_files({ cwd = utils.buffer_dir() }) end, desc = "Find Files (bufferdir)" },
        { "<leader>fr", function() builtin.oldfiles({ cwd = vim.loop.cwd() }) end, desc = "Recent (workspace)" },
        { "<leader>fR", function() builtin.oldfiles() end, desc = "Recent" },
        -- git
        { "<leader>gc", function() builtin.git_commits() end, desc = "commits" },
        { "<leader>gs", function() builtin.git_status() end, desc = "status" },
        -- search
        { '<leader>s"', function() builtin.registers() end, desc = "Registers" },
        { "<leader>sd", function() builtin.diagnostics({ bufnr=0 }) end, desc = "Document diagnostics" },
        { "<leader>sD", function() builtin.diagnostics() end, desc = "Workspace diagnostics" },
        { "<leader>sg", function() builtin.live_grep() end, desc = "Grep (workspace)" },
        { "<leader>sG", function() builtin.live_grep({ cwd = utils.buffer_dir() }) end, desc = "Grep (bufferdir)" },
        { "<leader>sb", function() builtin.current_buffer_fuzzy_find() end, desc = "Buffer search" },
        { "<leader>sm", function() builtin.marks() end, desc = "Jump to Mark" },
        { "<leader>.", function() builtin.resume() end, desc = "Recent Picker" },

        -- helpers
        { "<leader>ha", function() builtin.autocommands() end, desc = "Auto Commands" },
        { "<leader>hc", function() builtin.commands() end, desc = "Commands" },
        { "<leader>hh", function() builtin.help_tags() end, desc = "Help Pages" },
        { "<leader>hl", function() builtin.highlights() end, desc = "Highlight Groups" },
        { "<leader>hk", function() builtin.keymaps() end, desc = "Key Maps" },
        { "<leader>hm", function() builtin.man_pages() end, desc = "Man Pages" },
        { "<leader>ho", function() builtin.vim_options() end, desc = "Options" },

        { "<leader>sw", function() builtin.grep_string({ word_match = "-w" }) end, desc = "Word (workspace)" },
        { "<leader>sW", function() builtin.grep_string({ cwd = false, word_match = "-w" }) end, desc = "Word (bufferdir)" },
        { "<leader>sw", function() builtin.grep_string() end, mode = "v", desc = "Selection (workspace)" },
        { "<leader>sw", function() builtin.grep_string({ cwd = false }) end, mode = "v", desc = "Selection (bufferdir)" },
        { "<leader>uC", function() builtin.colorscheme({ enable_preview = true }) end, desc = "Colorscheme" },
        -- stylua: ignore
        { "<leader>ss", function() builtin.lsp_document_symbols({ symbols = require("lazyvim.config").get_kind_filter() }) end, desc = "Goto Symbol" },
        -- stylua: ignore
        { "<leader>sS", function() builtin.lsp_dynamic_workspace_symbols({ symbols = lazyvimConfig.get_kind_filter() }) end, desc = "Goto Symbol (Workspace)" },
        { "<localleader>l", function() builtin.lsp_references() end, desc = "References" },
        { "<localleader>j", function() builtin.lsp_definitions() end, desc = "Definitions" },
        { "<localleader>k", function() builtin.lsp_type_definitions() end, desc = "Type Definitions" },
      }
    end,
  },
}
