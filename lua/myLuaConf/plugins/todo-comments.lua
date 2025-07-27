--stylua: ignore start
-- This plugin will highlight the following comments:
--
--
-- COMMON KEYWORDS
----------------------
--
-- FIX:
-- FIXME:
-- BUG:
-- BUGFIX:
-- ISSUE:
-- TODO:
-- LATER:
-- ERROR:
-- DANGER:
-- HACK:
-- WARN:
-- WARNING:
-- XXX:
-- PERF:
-- PERFORMANCE:
-- OPTIM:
-- OPTIMIZE:
-- NOTE:
-- INFO:
-- TEST:
-- TESTING:
-- PASSED:
-- FAILED:
--
-- CUSTOM
----------------------
--
-- GP:         for personal comments & attribution
--@GP:         for personal comments & attribution
-- LINK:       for stand-out URL references
-- ASSERT:     for stand-out assertion notes
-- DESC:       for 'description' comments in code files ; inline comments that explain a small section of code within a function
-- THEME:      for nice formatting of theme descriptions in `user.colorscheme`
-- UTIL:       for stand-out utility function marking
-- MARK:       swift-style mark comments 
-- SECTION:    for denoting sections of code
-- END:        for denoting the end of sections
-- HISTORY:    file history markers 

return {
  {
    "todo-comments.nvim",
    for_cat = 'general.always',
    cmd = { "TodoTelescope" },
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    -- after = function (plugin)
    --
    -- end,
    opts = {
      keywords = {
        FIX = {
          icon = " ",      -- icon used for the sign, and in search results
          color = "error",  -- can be a hex color, or a named color (see below)
          -- signs = false, -- configure signs for some keywords individually
          alt = {           -- a set of other keywords that all map to this FIX keywords
            "FIXME", "BUG", "BUGFIX", "ISSUE", "DANGER"
          },
        },

        ERROR = {
          icon = " ",      -- icon used for the sign, and in search results
          color = "error",  -- can be a hex color, or a named color (see below)
          -- signs = false, -- configure signs for some keywords individually
          alt = {           -- a set of other keywords that all map to this FIX keywords
            "ERR",
          },
        },

        TODO = { icon = " ", color = "error", alt = { "LATER" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󱦺 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰍨 ", color = "hint" },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },

        -- MARK: CUSTOM:
        THEME = { icon = " ", color = "info" },
        DESC = { icon = "󰍨 ", color = "info", alt = { "INFO" } },
        ASSERT = { icon = "⏲ ", color = "test", alt = { "ASSERTION", "CHECK", "GUARD" } },
        LINK = { icon = " ", color = "link" },
        GP = { icon = " ", color = "link" },
        UTIL = { icon = " ", color = "warning" },
        MARK = { icon = " ", color = "warning", alt = { "SECTION", "END" } },
        HISTORY = { icon = "󱦺 " },
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
        link = { "#2563EB" },
      },
    },
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

