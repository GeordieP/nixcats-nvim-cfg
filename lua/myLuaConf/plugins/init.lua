-- NOTE: CODE DUPE 153007272015
local colorschemeName = nixCats('colorscheme')
if not require('nixCatsUtils').isNixCats then
  colorschemeName = 'onedark'
end
-- Could I lazy load on colorscheme with lze?
-- sure. But I was going to call vim.cmd.colorscheme() during startup anyway
-- this is just an example, feel free to do a better job!
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  })
  vim.notify = notify
  vim.keymap.set("n", "<Esc>", function()
      notify.dismiss({ silent = true, })
  end, { desc = "dismiss notify popup and clear hlsearch" })
end
-- NOTE: you can check if you included the category with the thing wherever you want.
-- if nixCats('general.extra') then
  -- I didnt want to bother with lazy loading this.
  -- I could put it in opt and put it in a spec anyway
  -- and then not set any handlers and it would load at startup,
  -- but why... I guess I could make it load
  -- after the other lze definitions in the next call using priority value?
  -- didnt seem necessary.
-- end

require('lze').load {
  {
    "trouble",
    -- event = "DeferredUIEnter",
    for_cat = 'general.always',
    cmd = "Trouble",
    after = function()
      require("trouble").setup({})
    end,
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "opencode",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    keys = {
       -- Recommended keymaps
      { '<leader>oA', function() require('opencode').ask() end, desc = 'Ask opencode', },
      { '<leader>oa', function() require('opencode').ask('@cursor: ') end, desc = 'Ask opencode about this', mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle embedded opencode', },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>oy', function() require('opencode').commang('messages_copy') end, desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
      { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      -- Example: keymap for custom prompt
      { '<leader>oe', function() require('opencode').prompt("Explain @cursor and its context") end, desc = "Explain code near cursor", },
    }
  },
  {
    -- https://github.com/mg979/vim-visual-multi
    -- Multiple cursors plugin for vim/neovim
    "vim-visual-multi",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
  },
  {
    "yazi",
    for_cat = 'general.extra',
    cmd = { "Yazi" },
    after = function(plugin)
      vim.g.loaded_netrwPlugin = 1
      require("yazi").setup({
        opts = {
          -- if you want to open yazi instead of netrw, see below for more info
          open_for_directories = true,

          -- enable these if you are using the latest version of yazi
          -- use_ya_for_events_reading = true,
          -- use_yazi_client_id_flag = true,

          keymaps = {
            show_help = "<f1>",
          },
        },
      })
    end,
    keys = {
      {
        "<leader><leader>",
        function()
          require("yazi").yazi()
        end,
        mode = {"n"},
        noremap = true,
        desc = "Open the file manager (yazi)",
      },
      -- {
      --   -- Open in the current working directory
      --   "<leader>cw",
      --   function()
      --     require("yazi").yazi(nil, vim.fn.getcwd())
      --   end,
      --   desc = "Open the file manager in nvim's working directory" ,
      -- },
      -- {
      --   '<c-up>',
      --   function()
      --     -- NOTE: requires a version of yazi that includes
      --     -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      --     require('yazi').toggle()
      --   end,
      --   desc = "Resume the last yazi session",
      -- },
    },
  },
  {
    "lazygit.nvim",
    for_cat = 'general.extra',
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    after = function(plugin)
      require('lazygit').setup()
    end,
    keys = {
      { "lg", function() require("lazygit").lazygitcurrentfile() end, desc = "Open LazyGit" },
    },
  },
  {
    "markdown-preview.nvim",
    -- NOTE: for_cat is a custom handler that just sets enabled value for us,
    -- based on result of nixCats('cat.name') and allows us to set a different default if we wish
    -- it is defined in luaUtils template in lua/nixCatsUtils/lzUtils.lua
    -- you could replace this with enabled = nixCats('cat.name') == true
    -- if you didnt care to set a different default for when not using nix than the default you already set
    for_cat = 'general.markdown',
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle", },
    ft = "markdown",
    keys = {
      {"<leader>mp", "<cmd>MarkdownPreview <CR>", mode = {"n"}, noremap = true, desc = "markdown preview"},
      {"<leader>ms", "<cmd>MarkdownPreviewStop <CR>", mode = {"n"}, noremap = true, desc = "markdown preview stop"},
      {"<leader>mt", "<cmd>MarkdownPreviewToggle <CR>", mode = {"n"}, noremap = true, desc = "markdown preview toggle"},
    },
    before = function(plugin)
      vim.g.mkdp_auto_close = 0
    end,
  },
  {
    "undotree",
    for_cat = 'general.extra',
    cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo", },
    keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" }, },
    before = function(_)
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
  {
    "comment.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function(plugin)
      require('Comment').setup()
    end,
  },
  {
    "indent-blankline.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function(plugin)
      require("ibl").setup()
    end,
  },
  {
    "nvim-surround",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require('nvim-surround').setup()
    end,
  },
  {
    "vim-startuptime",
    for_cat = 'general.extra',
    cmd = { "StartupTime" },
    before = function(_)
      vim.g.startuptime_event_width = 0
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_path = nixCats.packageBinPath
    end,
  },
  {
    -- https://github.com/j-hui/fidget.nvim 
    -- 💫 Extensible UI for Neovim notifications and LSP progress messages.
    "fidget.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require('fidget').setup({})
    end,
  },
  {
    -- https://github.com/folke/flash.nvim
    -- Navigate your code with search labels, enhanced character motions and Treesitter integration
    "flash",
    for_cat = 'general.always',
    after = function(plugin)
      require("flash").setup({
          -- NOTE: labels below are optimized for a split columnar COLEMAK-DH keyboard
          labels = "yquwlpjhzxkcdvatriseon",
          label = {
            after = false,
            before = true,

            rainbow = {
              enabled = true,
              -- shade = number between 1 (light) and 9 (dark)
              -- shade = 1,
              -- shade = 2,
              shade = 3,
              -- shade = 4,
              -- shade = 5,
              -- shade = 6,
              -- shade = 7,
              -- shade = 8,
              -- shade = 9,
            },
          },
          modes = {
            char = { enabled = false }
          }
      })
    end,
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- {
  --   "hlargs",
  --   for_cat = 'general.extra',
  --   event = "DeferredUIEnter",
  --   -- keys = "",
  --   dep_of = { "nvim-lspconfig" },
  --   after = function(plugin)
  --     require('hlargs').setup {
  --       color = '#32a88f',
  --     }
  --     vim.cmd([[hi clear @lsp.type.parameter]])
  --     vim.cmd([[hi link @lsp.type.parameter Hlargs]])
  --   end,
  -- },
  {
    "gitsigns.nvim",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    -- cmd = { "" },
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function (plugin)
      require('gitsigns').setup({
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map({ 'n', 'v' }, ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to next hunk' })

          map({ 'n', 'v' }, '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Jump to previous hunk' })

          -- Actions
          -- visual mode
          map('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'stage git hunk' })
          map('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'reset git hunk' })
          -- normal mode
          map('n', '<leader>gs', gs.stage_hunk, { desc = 'git stage hunk' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = 'git reset hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'git Stage buffer' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = 'git Reset buffer' })
          map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview git hunk' })
          map('n', '<leader>gb', function()
            gs.blame_line { full = false }
          end, { desc = 'git blame line' })
          map('n', '<leader>gd', gs.diffthis, { desc = 'git diff against index' })
          map('n', '<leader>gD', function()
            gs.diffthis '~'
          end, { desc = 'git diff against last commit' })

          -- Toggles
          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
          map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'toggle git show deleted' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
        end,
      })
      vim.cmd([[hi GitSignsAdd guifg=#04de21]])
      vim.cmd([[hi GitSignsChange guifg=#83fce6]])
      vim.cmd([[hi GitSignsDelete guifg=#fa2525]])
    end,
  },
  {
    "which-key.nvim",
    for_cat = 'general.extra',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function (plugin)
      require('which-key').add {
        -- { "<leader><leader>", group = "buffer commands" }, -- GP: removed because it conflicts with yazi key bind (<leader><leader>)
        -- { "<leader><leader>_", hidden = true },
        { "<leader>c", group = "[c]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[d]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>g", group = "[g]it" },
        { "<leader>g_", hidden = true },
        { "<leader>m", group = "[m]arkdown" },
        { "<leader>m_", hidden = true },
        { "<leader>r", group = "[r]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[s]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[t]oggles" },
        { "<leader>t_", hidden = true },
        { "<leader>w", group = "[w]orkspace" },
        { "<leader>w_", hidden = true },
      }
    end,
  },
  { import = "myLuaConf.plugins.telescope", },
  { import = "myLuaConf.plugins.treesitter", },
  { import = "myLuaConf.plugins.completion", },
  { import = "myLuaConf.plugins.lualine", },
  { import = "myLuaConf.plugins.todo-comments", },
}
