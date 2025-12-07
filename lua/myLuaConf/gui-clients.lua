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
--       and so it follows the telescope-menu command structure.
--
--       To change the default GUI font:
--       from the fonts table below, choose a  INFO: FONT_INDEX number,
--       then change the DEFAULT_FONT_INDEX.

local DEFAULT_FONT_INDEX = 12

local gui_font_options = {
  items = {
    -- SECTION: [sm]
    -- INFO: FONT_INDEX: 1
    {
      "[sm] Monaspace Xenon:h9 | linespace 4",
      function()
        vim.opt.guifont = "Monaspace Xenon:h9"
        vim.opt.linespace = 4
      end,
    },
    -- INFO: FONT_INDEX: 2
    {
      "[sm] Berkeley Mono Variable:h9 | linespace 0",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h9"
        vim.opt.linespace = 0
      end,
    },
    -- INFO: FONT_INDEX: 3
    {
      "[sm] Berkeley Mono Variable:h10 | linespace 0",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h10"
        vim.opt.linespace = 0
      end,
    },
    -- SECTION: [md]
    -- INFO: FONT_INDEX: 4
    {
      "[md] JetBrains Mono:h11 | linespace 5",
      function()
        vim.opt.guifont = "JetBrains Mono:h11"
        vim.opt.linespace = 5
      end,
    },
    -- INFO: FONT_INDEX: 5
    {
      "[lg][ls-3] Monaspace Xenon:h10",
      function()
        vim.opt.guifont = "Monaspace Xenon:h10"
        vim.opt.linespace = 3
      end,
    },
    -- INFO: FONT_INDEX: 6
    {
      "[md][ls-0] Berkeley Mono Variable:h11",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h11"
        vim.opt.linespace = 0
      end,
    },
    -- INFO: FONT_INDEX: 7
    {
      "[md][ls-5] Berkeley Mono Variable:h11",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h11"
        vim.opt.linespace = 5
      end,
    },
    -- SECTION: [lg]
    -- INFO: FONT_INDEX: 8
    {
      "[lg][ls-8] Monaspace Xenon SemiBold:h11",
      function()
        vim.opt.guifont = "Monaspace Xenon SemiBold:h11"
        vim.opt.linespace = 8
      end,
    },
    -- INFO: FONT_INDEX: 9
    {
      "[lg][ls-5] Berkeley Mono Variable:h12",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h12"
        vim.opt.linespace = 5
      end,
    },
    -- INFO: FONT_INDEX: 10
    {
      "[lg][ls-0] Berkeley Mono Variable:h12",
      function()
        vim.opt.guifont = "Berkeley Mono Variable:h12"
        vim.opt.linespace = 0
      end,
    },
    -- SECTION: [xl]
    -- INFO: FONT_INDEX: 11
    {
      "[xl][ls-8] Monaspace Xenon SemiBold:h13",
      function()
        vim.opt.guifont = "Monaspace Xenon SemiBold:h13"
        vim.opt.linespace = 8
      end,
    },
    -- INFO: FONT_INDEX: 12
    {
      "[xl][ls-5] Anka/Coder:h12",
      function()
        vim.opt.guifont = "Anka/Coder:h12"
        vim.opt.linespace = 5
      end,
    },
  },
}

gui_font_options.items[DEFAULT_FONT_INDEX][2]()

local M = {}
M.gui_font_options = gui_font_options
return M
