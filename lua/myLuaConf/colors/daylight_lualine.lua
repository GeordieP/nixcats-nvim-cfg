local lush = require('lush')
local hsl = lush.hsl

local black = hsl(0, 0, 0).hex
local white = hsl(255, 255, 255).hex

return {
  normal = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  insert = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  visual = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  replace = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  command = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  terminal = {
    a = { fg = black, bg = white, gui = 'bold' },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
  inactive = {
    a = { fg = white, bg = black },
    b = { fg = white, bg = black },
    c = { fg = white, bg = black },
  },
}
