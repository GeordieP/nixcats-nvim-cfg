local M = {}

-- INFO:
--       as of writing, there aren't any `error()` calls in this file, because we don't want to halt
--       the editor when something as simple as light/dark mode fails to work

M.file_path = vim.fn.stdpath "state" .. "/colormode-cache.txt"
M.default_colormode = "dark"

function M.get_color_mode()
  local initial_colormode_file = io.open(M.file_path, "r")
  if initial_colormode_file then
    local initial_colormode = initial_colormode_file:read "*a"
    initial_colormode_file:close()
    return initial_colormode
  else
    vim.print "[GP] initial_colormode_file failed to read the initial color mode file"
    return M.default_colormode
  end
end

local function persist_color_mode(new_colormode)
  if new_colormode == "light" or new_colormode == "dark" then
    local colormode_file = io.open(M.file_path, "w")
    if colormode_file then
      colormode_file:write(new_colormode)
      colormode_file:close()
    else
      vim.print("[GP] persist_color_mode failed to save the file" .. new_colormode)
    end
  else
    vim.print("[GP] persist_color_mode got invalid color mode" .. new_colormode)
  end
end

function M.set_color_mode(new_colormode)
  if new_colormode == "light" or new_colormode == "dark" then
    vim.o.background = new_colormode
    persist_color_mode(new_colormode)
  else
    vim.print("[GP] set_color_mode got invalid color mode" .. new_colormode)
  end
end

return M

