
-- NOTE: various, non-plugin config
require('myLuaConf.options')
require('myLuaConf.keys')
require('myLuaConf.gui-clients')

-- NOTE: register an extra lze handler with the spec_field 'for_cat'
-- that makes enabling an lze spec for a category slightly nicer
require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require('lze').register_handlers(require('lzextras').lsp)
-- demonstrated in ./LSPs/init.lua

-- NOTE: general plugins
require("myLuaConf.plugins")

-- NOTE: obviously, more plugins, but more organized by what they do below

require("myLuaConf.LSPs")

-- NOTE: we even ask nixCats if we included our debug stuff in this setup! (we didnt)
-- But we have a good base setup here as an example anyway!
if nixCats('debug') then
  require('myLuaConf.debug')
end
-- NOTE: we included these though! Or, at least, the category is enabled.
-- these contain nvim-lint and conform setups.
if nixCats('lint') then
  require('myLuaConf.lint')
end
if nixCats('format') then
  require('myLuaConf.format')
end
-- NOTE: I didnt actually include any linters or formatters in this configuration,
-- but it is enough to serve as an example.


-- TODO: move to autocmds

-- TODO: this is not working yet
--       it's supposed to make it so yazi opens instantly, when we open nvim on a directory path
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local argc = vim.fn.argc()
    local argv = vim.v.argv

    -- Skip the first argument (it's usually "nvim")
    local paths = {}
    for i = 1, #argv do
      if not argv[i]:match("^%-%-") then  -- skip flags like --embed, --headless
        table.insert(paths, argv[i])
      end
    end

    if argc == 0 then
      print("Started with no file or directory.")
    else
      -- Check the first argument passed
      local path = paths[1]
      local stat = vim.loop.fs_stat(path)

      if stat then
        if stat.type == "directory" then
          require("yazi").yazi()
        end
      end
    end
  end
})
