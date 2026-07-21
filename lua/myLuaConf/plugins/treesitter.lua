-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
--
-- NOTE: nvim-treesitter's `master` branch (with `require('nvim-treesitter.configs').setup{}`)
-- is gone. nixpkgs now ships the `main`-branch rewrite, which has a completely
-- different API:
--   * highlighting is enabled per-buffer with `vim.treesitter.start()`
--   * `incremental_selection` was removed (reimplemented below)
--   * `nvim-treesitter-textobjects` has its own new setup + explicit keymaps
-- Parsers are provided by nix (`nvim-treesitter.withAllGrammars`), so no install step.
return {
  {
    "nvim-treesitter",
    for_cat = 'general.treesitter',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    load = function (name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-treesitter-textobjects")
    end,
    after = function (plugin)
      -- [[ Highlighting ]]
      -- The main branch has no `highlight.enable`; you start treesitter per buffer.
      -- `vim.treesitter.start()` infers the parser from the buffer's filetype.
      local function ts_start(bufnr)
        pcall(vim.treesitter.start, bufnr)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('myLuaConf.treesitter', { clear = true }),
        callback = function(ev)
          ts_start(ev.buf)
        end,
      })

      -- We register the FileType autocmd during DeferredUIEnter, after the first
      -- buffer's FileType has already fired, so kick off any already-open buffers.
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
          ts_start(bufnr)
        end
      end

      -- [[ Indentation ]]
      -- Original config had `indent = { enable = false }`, so we deliberately do
      -- NOT set `indentexpr`. To enable the (experimental) treesitter indent later:
      --   vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      -- [[ Incremental selection ]]
      -- Reimplemented, since the main branch dropped this feature.
      -- <c-space> : start / expand to parent node
      -- <c-s>     : expand to the enclosing named ancestor (scope-ish)
      -- <M-space> : shrink to the previous selection
      do
        local api = vim.api
        local stack = {} -- stack of {srow, scol, erow, ecol} (0-indexed, end-exclusive)

        local function same_range(a, b)
          return a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and a[4] == b[4]
        end

        local function node_range(node)
          local srow, scol, erow, ecol = node:range()
          return { srow, scol, erow, ecol }
        end

        local function visual_select(range)
          -- Leave any current visual mode first so `v` starts a fresh selection.
          if vim.fn.mode():match('[vV\22]') then
            api.nvim_feedkeys(api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
          end
          local srow, scol, erow, ecol = range[1], range[2], range[3], range[4]
          local end_col = ecol
          local end_row = erow
          -- ts end col is exclusive; step back one for an inclusive visual selection.
          if end_col > 0 then
            end_col = end_col - 1
          elseif end_row > srow then
            end_row = end_row - 1
            end_col = math.max(#(api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1] or '') - 1, 0)
          end
          api.nvim_win_set_cursor(0, { srow + 1, scol })
          vim.cmd('normal! v')
          api.nvim_win_set_cursor(0, { end_row + 1, end_col })
        end

        local function init_selection()
          local node = vim.treesitter.get_node()
          if not node then return end
          stack = { node_range(node) }
          visual_select(stack[1])
        end

        local function expand(scope)
          local top = stack[#stack]
          if not top then return init_selection() end
          local node = vim.treesitter.get_node({ pos = { top[1], top[2] } })
          if not node then return init_selection() end
          -- Walk up until we find an ancestor that actually grows the selection.
          local parent = node:parent()
          while parent do
            local r = node_range(parent)
            if not same_range(r, top) then
              -- For scope expansion, prefer a "bigger" multi-line ancestor.
              if not scope or r[3] > r[1] then
                stack[#stack + 1] = r
                visual_select(r)
                return
              end
            end
            parent = parent:parent()
          end
          -- No larger node; keep current selection.
          visual_select(top)
        end

        local function shrink()
          if #stack > 1 then
            stack[#stack] = nil
          end
          local top = stack[#stack]
          if top then visual_select(top) end
        end

        vim.keymap.set('n', '<c-space>', init_selection, { desc = 'TS: init selection' })
        vim.keymap.set('x', '<c-space>', function() expand(false) end, { desc = 'TS: expand node' })
        vim.keymap.set('x', '<c-s>', function() expand(true) end, { desc = 'TS: expand scope' })
        vim.keymap.set('x', '<M-space>', shrink, { desc = 'TS: shrink selection' })
      end

      -- [[ Treesitter textobjects (main branch) ]]
      local ok_to = pcall(require, 'nvim-treesitter-textobjects')
      if ok_to then
        require('nvim-treesitter-textobjects').setup {
          select = {
            lookahead = true, -- jump forward to textobj, similar to targets.vim
          },
          move = {
            set_jumps = true, -- store movements in the jumplist
          },
        }

        local select = require('nvim-treesitter-textobjects.select')
        local move = require('nvim-treesitter-textobjects.move')
        local swap = require('nvim-treesitter-textobjects.swap')

        -- select: capture groups from textobjects.scm
        local sel_maps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        }
        for lhs, query in pairs(sel_maps) do
          vim.keymap.set({ 'x', 'o' }, lhs, function()
            select.select_textobject(query, 'textobjects')
          end, { desc = 'TS select ' .. query })
        end

        -- move
        vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
          move.goto_next_start('@function.outer', 'textobjects')
        end, { desc = 'TS next function start' })
        vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
          move.goto_next_end('@function.outer', 'textobjects')
        end, { desc = 'TS next function end' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
          move.goto_previous_start('@function.outer', 'textobjects')
        end, { desc = 'TS prev function start' })
        vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
          move.goto_previous_end('@function.outer', 'textobjects')
        end, { desc = 'TS prev function end' })

        -- swap
        vim.keymap.set('n', '<leader>a', function()
          swap.swap_next('@parameter.inner')
        end, { desc = 'TS swap next parameter' })
        vim.keymap.set('n', '<leader>A', function()
          swap.swap_previous('@parameter.inner')
        end, { desc = 'TS swap previous parameter' })
      end
    end,
  },
}
