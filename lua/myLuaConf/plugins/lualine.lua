-- NOTE: CODE DUPE 153007272015
local colorschemeName = nixCats('colorscheme')
if not require('nixCatsUtils').isNixCats then
  colorschemeName = 'onedark'
end

local function custom_mode()
  -- Adapted from https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua#L6
  local mode_code = vim.api.nvim_get_mode().mode

  local customModeMap = {
    ['n']      = 'N',
    ['no']     = 'O',
    ['nov']    = 'O',
    ['noV']    = 'O',
    ['no\22']  = 'O',
    ['niI']    = 'N',
    ['niR']    = 'N',
    ['niV']    = 'N',
    ['nt']     = 'N',
    ['ntT']    = 'N',
    ['v']      = 'V',
    ['vs']     = 'V',
    ['V']      = 'V',
    ['Vs']     = 'V',
    ['\22']    = 'V',
    ['\22s']   = 'V',
    ['s']      = 'S',
    ['S']      = 'S',
    ['\19']    = 'S',
    ['i']      = 'I',
    ['ic']     = 'I',
    ['ix']     = 'I',
    ['R']      = 'R',
    ['Rc']     = 'R',
    ['Rx']     = 'R',
    ['Rv']     = 'VR',
    ['Rvc']    = 'VR',
    ['Rvx']    = 'VR',
    ['c']      = 'C',
    ['cv']     = 'X',
    ['ce']     = 'X',
    ['r']      = 'R ',
    ['rm']     = 'M ',
    ['r?']     = 'CONFIRM',
    ['!']      = 'SHELL',
    ['t']      = 'TERMINAL',
  }

  if customModeMap[mode_code] == nil then
    return mode_code
  end
  return customModeMap[mode_code]
  -- return '∞ ' .. customModeMap[mode_code]
end

return {
  {
    "lualine.nvim",
    for_cat = 'general.always',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function (plugin)
      require('lualine').setup({
        options = {
          icons_enabled = false,
          theme = colorschemeName,
          -- component_separators = '|',
          -- section_separators = '',
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = { custom_mode },
          lualine_c = {
            {
              'filename', path = 1, status = true,
            },
          },
        },
        inactive_sections = {
          lualine_b = {
            {
              'filename', path = 3, status = true,
            },
          },
          lualine_x = {'filetype'},
        },
        tabline = {
          lualine_a = { 'buffers' },
          -- if you use lualine-lsp-progress, I have mine here instead of fidget
          lualine_b = { 'lsp_progress', },
          lualine_z = { 'tabs' }
        },
      })
    end,
  },
}


-- options from old config:

    -- options = {
      -- some extra characters from https://unicode.bayashi.net/?page=1797
      --                
      -- --
      -- blocks
      -- component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },

      -- arrows
      -- component_separators = { left = '', right = ''},
      -- section_separators = { left = '', right = ''},

      -- bubbles
      -- section_separators = { left = '', right = '' },
      -- component_separators = { left = '', right = '' },

      -- downward slants
      -- component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },

      -- upward slants
      -- component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },

      -- combined slants
      -- component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },

      -- ignore_focus = { "NvimTree" },
    -- },
    -- sections = {
      -- lualine_a = { {"branch", icon =""} },
      -- lualine_b = { diff },
      -- lualine_c = { "diagnostics" },
      -- lualine_x = { copilot },
      -- lualine_y = { "filetype" },
      -- lualine_z = { "progress" },
      --
      -- lualine_a = { "mode" },
      -- lualine_a = { custom_mode },
      -- lualine_b = {},
      -- lualine_c = { },
      -- lualine_w = { diff },
      -- lualine_x = { "diagnostics", copilot  },
      -- lualine_y = { "filetype" },
      -- lualine_z = { "location" },
      --
      -- lualine_b = {
      --   {
      --     "navic",
      --     -- below: trying to get colored icons rendering, but it's not working.
      --     --        they aren't colored in the breadcrumbs bar either, so maybe it's colorscheme related.
      --     -- color_correction = "static",
      --     -- navic_opts = { highlight = true },
      --   }
      -- },
      -- lualine_c = {},
      -- lualine_x = { "diagnostics", diff },
      -- lualine_y = { "filetype" },
      -- lualine_z = { "location" },
    -- },
    -- extensions = { "quickfix", "man", "fugitive" },
  -- }

