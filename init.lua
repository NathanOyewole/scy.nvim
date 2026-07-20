-- ===============================
-- Core Options
-- ===============================
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
-- Adding these for a better terminal-centric experience
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

-- Leader key
vim.g.mapleader = " "

-- ===============================
-- lazy.nvim bootstrap
-- ===============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===============================
-- Load Plugins & Keymaps
-- ===============================
require("lazy").setup({
  spec = { { import = "plugins" } },
  rocks = {
    enabled = false,
  },
}) -- Note: Passing the string "plugins" usually loads lua/plugins.lua or lua/plugins/init.lua automatically
require("keymaps")

-- ===============================
-- Colorscheme & UI Overrides
-- ===============================
vim.cmd.colorscheme("PaperColor")

-- Optimization: Move highlight settings to a separate 'after/plugin/highlights.lua'
-- or inside your plugin config to avoid running them every time init.lua loads.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#3b4048" })
    vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#7f848e" })
  end,
})
