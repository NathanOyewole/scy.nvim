local M = {}

M.themes = {
  "catppuccin",
  "tokyonight",
  "gruvbox",
  "onedark",
  "everforest",
  "nightfox",
  "kanagawa",
  "nord",
  "PaperColor",
  "moonfly",
}

M.index = 1

function M.set(name)
  -- 1. Reset everything to default to avoid "zombie" colors from the previous theme
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

  -- 2. Use pcall to apply the theme safely
  local ok = pcall(vim.cmd.colorscheme, name)

  if ok then
    vim.notify("🎨 Theme: " .. name, vim.log.levels.INFO)
  else
    vim.notify("Failed to load theme: " .. name, vim.log.levels.ERROR)
    -- Fallback to a safe default if the theme fails
    vim.cmd.colorscheme("default")
  end
end

function M.next()
  M.index = (M.index % #M.themes) + 1
  M.set(M.themes[M.index])
end

function M.prev()
  M.index = (M.index - 2 + #M.themes) % #M.themes + 1
  M.set(M.themes[M.index])
end

return M
