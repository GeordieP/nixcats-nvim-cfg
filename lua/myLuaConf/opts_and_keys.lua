-- OPTS --------------------------------------------------------------------

vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp -- TODO: these may need to change. original value
-- vim.o.completeopt = 'menu,preview,noselect' -- TODO: this is the nixcats default

-- vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.conceallevel = 1 -- so that the obsidian plugin can render fancy checkboxes
-- vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 30 -- pop up menu height
-- vim.opt.pumblend = 10 -- pop up menu transparency
-- vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore -- TODO: did this depend on a plugin?
vim.opt.showtabline = 1 -- show/hide tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds) -- TODO: nixcats default is 300, try that
vim.opt.updatetime = 100 -- faster completion (4000ms default) -- TODO: nixcats default is 250, try that
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
-- vim.opt.cursorline = true -- highlight the current line
vim.opt.number = false -- set numbered lines
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 4 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 0
-- vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 0
-- vim.opt.sidescrolloff = 8

vim.opt.title = false
-- colorcolumn = "80",
-- colorcolumn = "120",
-- TODO: what does this do?
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append {
  stl = " ",
}

-- TODO: what does this do?
vim.opt.shortmess:append "c"

-- TODO: what does this do?
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2

-- Below adapted from nixcats repo

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview :s substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Indent
-- vim.o.smarttab = true -- TODO: Try both true and false in this. Default is ON (true)

-- Changes whether the cursor's column is remembered when navigating between lines
vim.opt.cpoptions:append('I') -- TODO: try this out? turn it off and see what changes?
-- vim.o.expandtab = true
-- vim.o.smartindent = true
-- vim.o.autoindent = true
-- vim.o.tabstop = 4
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4

-- stops line wrapping from being confusing
vim.o.breakindent = true -- TODO: try this out? turn it off and see what changes?


-- KEYS --------------------------------------------------------------------

-- TODO: make it so `enter` or `tab` work in autocomplete popups

-- NOTE: Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

-- Remap space as leader key
vim.keymap.set("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- C-Space to open which-key
-- vim.keymap.set("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts) -- TODO: re-enable 
-- vim.keymap.set("n", "<C-i>", "<C-i>", opts) -- TODO: what does this do? Just makes it noremap & silent?

-- Save files with ctrl-s
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)

-- window navigation
vim.keymap.set("n", "<leader>v", "<C-w>v<C-w>h") -- vertical window split
-- vim.keymap.set("n", "<leader>v", ":60 vsplit <CR><C-w>h", { silent = true }) -- vertical window split (60% size)
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- horizontal window split
vim.keymap.set("n", "<leader>c", ":close<CR>", { silent = true }) -- TODO: is there a better way to do this? I think people make plugins for this?
 -- maybe this is better?:
-- vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'delete buffer' })

vim.keymap.set("n", "<leader>w<Left>", "<C-w>h")
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j")
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k")
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l")
vim.keymap.set("n", "=", ":wincmd =<CR>")

-- Resize windows with arrow keys
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Movement and screen scrolling:
-- Arrow keys (on my keyboard the arrows are on the home row, arranged similar to hjkl) to scroll buffer around middle
-- vim.keymap.set("n", "<Up>", "kzz")
-- vim.keymap.set("n", "<Down>", "jzz")
-- Use Shift+Arrow (or hjkl) to move like traditional vim - pressing shift makes this feel like a "precision mode"
-- vim.keymap.set("n", "<S-Up>", "k")
-- vim.keymap.set("n", "<S-Down>", "j")
-- Apply the above rules to visual block mode too:
-- vim.keymap.set("x", "<Up>", "kzz")
-- vim.keymap.set("x", "<Down>", "jzz")
-- vim.keymap.set("x", "<S-Up>", "k")
-- vim.keymap.set("x", "<S-Down>", "j")

-- NOTE: deprecated :: trying to discourage use of these keys for naviagion!
--       Jump to next empty line (the { and } keys) also should scroll
--       vim.keymap.set("n", "}", "}zz", { noremap = true })
--       vim.keymap.set("n", "{", "{zz", { noremap = true })
--
--       unmap those buttons:
vim.keymap.set("n", "}", "")
vim.keymap.set("n", "{", "")

-- NOTE: favor movement style:
--       pageup & pagedown:
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- NOTE: quickfix list navigation
vim.keymap.set("n", "}}", "<cmd>cnext<cr>")
vim.keymap.set("n", "{{", "<cmd>cprev<cr>")

--       Initially set pageup & pagedown size (% of screen):
--        NOTE: doesn't work
-- vim.cmd [[:let key = nvim_replace_termcodes("1<C-u>", v:true, v:false, v:true)]]
-- vim.cmd [[:call nvim_feedkeys(key, 'n', v:false)]]

-- NOTE: favor movement style:
--       jump to next pair of braces
--       NOTE: these don't work too well in elixir.
--              maybe replace with: https://github.com/nvim-treesitter/nvim-treesitter-textobjects?tab=readme-ov-file#text-objects-move
vim.keymap.set("n", "]]", "]]zz", { noremap = true })
vim.keymap.set("n", "[[", "[[zz", { noremap = true })
vim.keymap.set("n", "]m", "]mzz", { noremap = true })
vim.keymap.set("n", "[m", "[mzz", { noremap = true })
vim.keymap.set("n", "]M", "]Mzz", { noremap = true })
vim.keymap.set("n", "[M", "[Mzz", { noremap = true })

-- Search jumping should also scroll
-- vim.keymap.set("n", "n", "nzz", { noremap = true }) -- older: this doesn't do zv (show cursorline)
-- vim.keymap.set("n", "N", "Nzz", { noremap = true }) -- older: this doesn't do zv (show cursorline)
vim.keymap.set("n", "n", "nzzzv", { noremap = true, desc = 'Next Search Result' })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, desc = 'Previous Search Result' })
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)

-- Center the view when scrolling pages
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll Down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll Up' })

-- Navigate buffers
-- TODO: maybe try something new for these
-- this conflicts with a nixcats example bind down below that shows diagnostics
-- 
vim.keymap.set("n", "<leader>q", ":bnext<CR>", opts)
vim.keymap.set("n", "<leader>z", ":bprevious<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Toggle search highlighting on/off with <Leader>x
vim.cmd [[:nnoremap <silent><expr> <Leader>x (&hls && v:hlsearch ? ':set nohls' : ':set hls')."\n"]]

-- Paste-and-replace without yanking in visual & visual block mode...
vim.keymap.set("x", [[p]], [["_dP]])
vim.keymap.set("v", [[p]], [["_dP]])
-- ...EXCEPT for global register +
vim.keymap.set("x", [["+p]], [["+p]])
vim.keymap.set("v", [["+p]], [["+p]])

-- NOTE: I mistakenly press shift+up/down a lot when I've just pressed shift-V to start a
--       selection, and then I press down to go to the next line before fully releasing shift.
-- FIX: In selection modes, rebind back to un-shifted up/down
vim.keymap.set("v", "<S-Down>", "<Down>")
vim.keymap.set("x", "<S-Down>", "<Down>")
vim.keymap.set("v", "<S-Up>", "<Up>")
vim.keymap.set("x", "<S-Up>", "<Up>")

-- LSP
-- Find additional LSP keybinds in `lspconfig.lua # lsp_keymaps()`

-- LSP mouse support
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

--
-- PLUGINS -- -- --
--

-- Telescope
-- Find additional telescope keybinds in `telescope.lua` under "mappings".
-- TODO: update these comments once whichkey is (or isnt) migrated
vim.keymap.set("n", "<leader>rg", ":Telescope live_grep<CR>", opts) -- live_grep also bound to a different combination in whichkey.lua
vim.keymap.set("n", "<leader>gf", ":Telescope find_files<CR>", opts) -- find_files also bound to a different combination in whichkey.lua
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)

-- Git
-- TODO: re-enable this
-- vim.keymap.set("n", "lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts) -- calls a function defined in toggleterm.lua
-- vim.keymap.set("n", "<leader>gb", "<cmd>:Gitsigns toggle_current_line_blame<CR>", opts)

-- No Neck Pain
-- Find NNP keybinds in `noneckpain.lua`

-- Comment

-- DAP
-- Find additional DAP keybinds in `dapui.lua`
-- TODO: re-enable this
-- vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Navbuddy
-- TODO: re-enable this
-- vim.keymap.set("n", "<leader>a", "<cmd>Navbuddy<cr>", opts) -- toggle symbols panel (aerial)

-- Harpoon
-- TODO: plugin setup
-- h key shows the marks edit window
-- vim.keymap.set("n", "<leader>h", "<cmd> lua require'harpoon.mark'.add_file()<cr>", opts)
-- vim.keymap.set("n", "<leader>hh", "<cmd> lua require'harpoon.ui'.toggle_quick_menu()<cr>", opts)
-- keys 1,2,3,4 and their shift variants are to set and navigate to bookmarks
-- 1!
-- vim.keymap.set("n", "<leader>1", "<cmd> lua require'harpoon.ui'.nav_file(1)<cr>", opts)
-- vim.keymap.set("n", "<leader>h1", "<cmd> lua require'harpoon.mark'.add_current_file(1)<cr>", opts)
-- 2@
-- vim.keymap.set("n", "<leader>2", "<cmd> lua require'harpoon.ui'.nav_file(2)<cr>", opts)
-- vim.keymap.set("n", "<leader>h2", "<cmd> lua require'harpoon.mark'.add_current_file(2)<cr>", opts)
-- 3#
-- vim.keymap.set("n", "<leader>3", "<cmd> lua require'harpoon.ui'.nav_file(3)<cr>", opts)
-- vim.keymap.set("n", "<leader>h3", "<cmd> lua require'harpoon.mark'.add_current_file(3)<cr>", opts)
-- 4$
-- vim.keymap.set("n", "<leader>4", "<cmd> lua require'harpoon.ui'.nav_file(4)<cr>", opts)
-- vim.keymap.set("n", "<leader>h4", "<cmd> lua require'harpoon.mark'.add_current_file(4)<cr>", opts)

-- Manually open the completion menu
vim.keymap.set("n", "<C-CR>", "lua cmp.complete({reason = cmp.ContextReason.Auto})", opts)

-- INFO: rebind * to not jump to the next occurrence
vim.keymap.set("n", "*", "<cmd>let @/ = expand('<cword>') | set hlsearch<cr>")
-- TODO: Make this work in visual and visual-block mode too
-- vim.keymap.set("v", "*", "<cmd>let @/ = expand('<cword>') | set hlsearch<cr>")
-- vim.keymap.set("v", "*", '<cmd>"zy | let @/ = @z | set hlsearch<cr>')
-- vim.keymap.set("x", "*", '<cmd>"zy | let @/ = @z | set hlsearch<cr>')

-- INFO: yank without losing selection.
--       has the side effect of making   Vyp   not work (becomes  Vy<esc>p  ).
--       a new bind is added in order to do that 'duplicate line' operation.
-- DEPRECATED: affects workflow too much.   Vyp    , viw<up>p     , probably more ..
-- vim.keymap.set("v", "y", "ygv")
-- vim.keymap.set("x", "y", "ygv")
-- keep the duplicate commands though:
vim.keymap.set("n", "<leader>d<down>", "yyp") -- duplicate DOWN (normal mode)
vim.keymap.set("n", "<leader>d<up>", "yyP") -- duplicate UP (normal mode)
vim.keymap.set("x", "<leader>d<down>", "ygv<esc>p") -- duplicate DOWN (visual block mode)
vim.keymap.set("x", "<leader>d<up>", "ygv<esc>p") -- duplicate UP (visual block mode)

vim.keymap.set("v", "<leader>d<down>", "ygv<esc>pi<cr><esc>w") -- duplicate DOWN (visual mode)
vim.keymap.set("v", "<leader>d<up>", "yP") -- duplicate UP (visual mode)

--
-- Below adapted from nixcats example -- -- --
--

-- see help sticky keys on windows
-- TODO: what does this do?
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Q q]])

-- Remap for dealing with word wrap
-- GP: this might relate to the `cpoptions:append('I')` option? 
--     not having this set means the cursor will skip past word wrapped lines when moving
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- GP: added for keeb support
vim.keymap.set('n', '<down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- GP: added for keeb support

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- TODO: this conflicts with buffer navigation, but that bind might change. come back to this if it does.
--       or, maybe this functionality should be handled by trouble.nvim instead?
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' }) 

-- You should instead use these keybindings so that they are still easy to use, but dont conflict
vim.keymap.set({"v", "x", "n"}, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
vim.keymap.set({"n", "v", "x"}, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'Select all' })
vim.keymap.set({'n', 'v', 'x'}, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set('i', '<C-p>', '<C-r><C-p>+', { noremap = true, silent = true, desc = 'Paste from clipboard from within insert mode' })
vim.keymap.set("x", "<leader>P", '"_dP', { noremap = true, silent = true, desc = 'Paste over selection without erasing unnamed register' })

----------------------------------------------------------------------------

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
  desc = "remove formatoptions",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- TODO: move to autocmds

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

