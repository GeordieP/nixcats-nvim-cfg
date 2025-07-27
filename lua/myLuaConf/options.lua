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
