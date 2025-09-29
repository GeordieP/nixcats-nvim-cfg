-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of help_tags options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
    })
  end
end

return {
  {
    "telescope.nvim",
    for_cat = 'general.telescope',
    cmd = { "Telescope", "LiveGrepGitRoot" },
    -- NOTE: our on attach function defines keybinds that call telescope.
    -- so, the on_require handler will load telescope when we use those.
    on_require = { "telescope", },
    -- event = "",
    -- ft = "",
    keys = {
      { "<leader>sM", '<cmd>Telescope notify<CR>', mode = {"n"}, desc = '[S]earch [M]essage', },
      { "<leader>sp",live_grep_git_root, mode = {"n"}, desc = '[S]earch git [P]roject root', },
      { "<leader>/", function()
        -- Slightly advanced example of overriding default behavior and theme
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, mode = {"n"}, desc = '[/] Fuzzily search in current buffer', },
      { "<leader>s/", function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, mode = {"n"}, desc = '[S]earch [/] in Open Files' },
      -- { "<leader><leader>s", function() return require('telescope.builtin').buffers() end, mode = {"n"}, desc = '[ ] Find existing buffers', }, -- GP: removed because it conflicts with yazi key bind (<leader><leader>)
      { "<leader>s.", function() return require('telescope.builtin').oldfiles() end, mode = {"n"}, desc = '[S]earch Recent Files ("." for repeat)', }, -- GP: same as old <leader>of. no preference, prob just get used to this new one
      { "<leader>sr", function() return require('telescope.builtin').resume() end, mode = {"n"}, desc = '[S]earch [R]esume', }, -- GP: same as old <leader>fl. <leader>sr is better, keeping it
      { "<leader>sd", function() return require('telescope.builtin').diagnostics() end, mode = {"n"}, desc = '[S]earch [D]iagnostics', }, -- GP: mostly replaces my use case for trouble.nvim ?
      { "<leader>sg", function() return require('telescope.builtin').live_grep() end, mode = {"n"}, desc = '[S]earch by [G]rep', }, -- GP: same as <leader>rg. no preference. see also <leader>sp which is a more useful search (from git root)
      { "<leader>sw", function() return require('telescope.builtin').grep_string() end, mode = {"n", "v"}, desc = '[S]earch current [W]ord', }, -- GP: same as visual mode <leader>g. keep both
      { "<leader>ss", function() return require('telescope.builtin').builtin() end, mode = {"n"}, desc = '[S]earch [S]elect Telescope', },
      { "<leader>sf", function() return require('telescope.builtin').find_files() end, mode = {"n"}, desc = '[S]earch [F]iles', }, -- GP: same as <leader>gf. prefer <leader>gf, works better on colemak
      { "<leader>sk", function() return require('telescope.builtin').keymaps() end, mode = {"n"}, desc = '[S]earch [K]eymaps', },
      { "<leader>sh", function() return require('telescope.builtin').help_tags() end, mode = {"n"}, desc = '[S]earch [H]elp', },
      { "<leader>sc", function() return require('telescope.builtin').colorscheme() end, mode = {"n"}, desc = '[S]earch [C]olorschemes', },
      { "<leader>sj", function() return require('telescope.builtin').jumplist() end, mode = {"n"}, desc = '[S]earch [J]jumplist', },
      { "<leader>sp", function() return require('telescope.builtin').planets() end, mode = {"n"}, desc = '[S]earch [P]lanets', }, -- GP: VERY important
      -- TODO: undo isn't working just yet, package does not seem to be installed right
      { "<leader>su", function() return require('telescope').extensions.undo.undo() end, mode = {"n"}, desc = '[S]earch [U]ndo history', }, -- GP: uses telescope-undo.nvim. undo/redo history for current buffer
      -- GP: TODO: <leader>slr search lsp references? sr would collide with `search resume`
      -- GP: TODO: other lsp things (see pickers setup below for some initial ones to support)
      -- GP: TODO: lsp ccode actions? (this was in old config but not through telescope https://github.com/gp-config/nvim/blob/main/lua/user/whichkey.lua#L107) -- NOTE: telescope-ui-select plugin already in here might do this automatically??
      -- GP: TODO: telescope custom menu https://github.com/gp-config/nvim/blob/main/lua/user/telescope-menu.lua -- go through this and remove anything unsupported
    },
    -- colorscheme = "",
    load = function (name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("telescope-fzf-native.nvim")
        vim.cmd.packadd("telescope-ui-select.nvim")
    end,
    after = function (plugin)
      local actions = require("telescope.actions")

      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = {
              ['<c-enter>'] = 'to_fuzzy_refine',
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_to_qflist,
            },
            n = {
              ["<esc>"] = actions.close,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["q"] = actions.close,
            },
          },
          entry_prefix = "   ",
          initial_mode = "insert",
          selection_strategy = "reset",
          path_display = { "smart" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          sorting_strategy = nil,
          layout_strategy = nil,
          layout_config = {},
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          file_ignore_patterns = { ".git/", "node_modules" },
        },
        pickers = {
          -- Themes docs: https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#themes
          live_grep = {
            theme = "ivy",
          },

          grep_string = {
            theme = "ivy",
          },

          -- find_files = {
          --   theme = "ivy",
          --   previewer = false,
          -- },

          buffers = {
            theme = "ivy",
            -- previewer = false,
            -- initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },

          -- oldfiles = {
          --   theme = "ivy",
            -- initial_mode = "normal",
            -- theme = "dropdown",
            -- previewer = false,
            --
          -- },

          planets = {
            show_pluto = true,
            show_moon = true,
          },

          colorscheme = {
            theme = "ivy",
            enable_preview = true,
          },

          lsp_references = {
            -- theme = "dropdown",
            theme = "ivy",
            initial_mode = "normal",
          },

          lsp_definitions = {
            theme = "ivy",
            initial_mode = "normal",
          },

          lsp_declarations = {
            theme = "ivy",
            initial_mode = "normal",
          },

          lsp_implementations = {
            theme = "ivy",
            initial_mode = "normal",
          },

          lsp_document_symbols = {
            theme = "ivy",
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          undo = {
            -- INFO: use_delta = false will DISABLE using the `delta` diff viewer. delta seems to look bad in light mode.
            use_delta = false,
            -- INFO: the side-by-side diff options below look great, but require use_delta = true; disabling for now
            -- side_by_side = true,
            -- layout_strategy = "vertical",
            -- layout_config = {
            --   preview_height = 0.8,
            -- },
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'undo')

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})


      --- telescope global search for highlighted text
      --- thanks to: adoyle-h on github https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431

      function vim.getVisualSelection()
        vim.cmd 'noau normal! "vy"'
        local text = vim.fn.getreg "v"
        vim.fn.setreg("v", {})

        text = string.gsub(text, "\n", "")
        if #text > 0 then
          return text
        else
          return ""
        end
      end

      vim.keymap.set("v", "<space>g", function()
        local text = vim.getVisualSelection()
        require("telescope.builtin").live_grep { default_text = text }
      end, { noremap = true, silent = true })

      --- end telescope global search for highlighted text
    end,
  },
}
