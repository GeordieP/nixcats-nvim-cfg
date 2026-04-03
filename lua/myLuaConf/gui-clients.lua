-- use this font for all GUI clients

-- NEOVIDE GUI:
-- https://neovide.dev/configuration.html
-- neovide sets this variable on startup. if it's not set, then we're not running in neovide.
if not vim.g.neovide then
  return {}
else
  vim.opt.clipboard = "" -- disables ext clipboard. tracking bug https://github.com/neovide/neovide/issues/2003

  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 2.0 -- default 7.0

  vim.g.neovide_refresh_rate = 120 -- only has an effect on high refresh displays.
  vim.g.neovide_refresh_rate_idle = 5

  vim.g.neovide_cursor_animation_length = 0.08 -- default 0.13
  vim.g.neovide_cursor_trail_size = 0.5 -- default 0.8

  vim.g.neovide_window_floating_opacity = 1
  vim.g.neovide_window_floating_blur = 1
  vim.g.neovide_floating_blur = 0

  vim.g.neovide_padding_top = 29
  vim.g.neovide_padding_right = 29
  -- vim.g.neovide_padding_bottom = 29 -- command line looks like padding already
  vim.g.neovide_padding_left = 29

  -- vim.g.neovide_scroll_animation_length = 0.15 -- snappy!
  vim.g.neovide_scroll_animation_length = 0.35 -- medium
  -- vim.g.neovide_scroll_animation_length = 0.65 -- smooooooth
end

-- NOTE: This gui_font_options table is used in telescope-menu.lua,
--       and so it gets mapped to the telescope-menu command structure.
--
--       To change the default GUI font:
--       in the row that should be default, change nil to true.
--       Make sure no other rows are also true.

--       Format the table using   vi{gas,

local gui_fonts_configuration_table = {
--+---------------------------------------------------------------------------- +
-- is          , font     , line       , font                                  ,
-- default [1] , size  [2], spacing [3], name [4]                              ,
  {nil         , 10       , 1          , "Anka/Coder"                          ,},
  {nil         , 12       , 2          , "Anka/Coder"                          ,},
  {nil         , 12       , 5          , "Anka/Coder"                          ,},
  {nil         , 14       , 8          , "Anka/Coder"                          ,},
  {nil         , 9        , 0          , "Berkeley Mono Variable"              ,},
  {true        , 10       , 0          , "Berkeley Mono Variable"              ,},
  {nil         , 10       , 5          , "Berkeley Mono Variable"              ,},
  {nil         , 11       , 0          , "Berkeley Mono Variable"              ,},
  {nil         , 11       , 5          , "Berkeley Mono Variable"              ,},
  {nil         , 12       , 0          , "Berkeley Mono Variable"              ,},
  {nil         , 12       , 5          , "Berkeley Mono Variable"              ,},
  {nil         , 9        , 0          , "Monaspace Xenon"                     ,},
  {nil         , 9        , 4          , "Monaspace Xenon"                     ,},
  {nil         , 10       , 3          , "Monaspace Xenon"                     ,},
  {nil         , 11       , 8          , "Monaspace Xenon"                     ,},
  {nil         , 11       , 8          , "Monaspace Xenon"                     ,},
  {nil         , 13       , 8          , "Monaspace Xenon"                     ,},
  {nil         , 9        , 0          , "JetBrains Mono"                      ,},
  {nil         , 10       , 3          , "JetBrains Mono"                      ,},
  {nil         , 11       , 5          , "JetBrains Mono"                      ,},
}

local function map_fonts_table(fonts_table)
  local mapped_rows = {}
  local found_default_idx = -1

  for row_idx, row in ipairs(fonts_table) do
    if row[1] == true then
      found_default_idx = row_idx
    end

    local h_text
    if row[2] > 9 then
      h_text = "[h"  .. row[2] .. "] "
    else
      h_text = "[h " .. row[2] .. "] "
    end

    local ls_text
    if row[3] > 9 then
      ls_text = "[ls"  .. row[3] .. "] "
    else
      ls_text = "[ls " .. row[3] .. "] "
    end

    mapped_rows[row_idx] = {
      -- INFO: h_text and ls_text are repeated for telescope-menu SEO,
      --       so that e.g. 'berk115' will match 'Berkeley Mono Variable [h11][ls 5]'
      h_text .. ls_text .. row[4] .. " " .. h_text .. ls_text,
      function()
        local guifont = row[4] .. ":h" .. row[2]
        local linespace = row[3]
        vim.opt.guifont = guifont
        vim.opt.linespace = linespace
      end
    }
  end

  -- INFO: append an extra action which prompts the user to set a custom font string
  mapped_rows[#mapped_rows + 1] = {
    "Custom size: Manually set a font string (e.g: JetBrains Mono:h12)",
    function()
      vim.ui.input({ prompt = "Font string (e.g: JetBrains Mono:h12): " }, function(input)
        if input == nil then
          print("Cancelled")
        else
          vim.opt.guifont = input
          print("✔  Set vim.opt.guifont to: " .. input)
        end
      end)
    end
  }

  -- INFO: append an extra action which prompts the user to set a custom line spacing
  mapped_rows[#mapped_rows + 1] = {
    "Custom spacing: Manually set a line spacing / line height (e.g: 4)",
    function()
      vim.ui.input({ prompt = "Spacing: (e.g: 4): " }, function(input)
        if input == nil then
          print("Cancelled")
        else
          vim.opt.linespace = tonumber(input)
          print("✔  Set vim.opt.linespace to: " .. tonumber(input))
        end
      end)
    end
  }

  -- INFO: SIDE EFFECT: If some row was marked as the default, run its function now.
  if found_default_idx > -1 then
    mapped_rows[found_default_idx][2]()
  end

  return mapped_rows
end

local M = {}
M.gui_font_options = { items = map_fonts_table(gui_fonts_configuration_table) }
return M

