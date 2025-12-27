-- ===============================
-- Core Options
-- ===============================
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

-- Leader key (BEFORE keymaps)
vim.g.mapleader = " "

-- ===============================
-- lazy.nvim bootstrap
-- ===============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
-- Load Plugins
-- ===============================
require("lazy").setup(require("plugins"))

-- ===============================
-- Keymaps
-- ===============================
require("keymaps")

-- ===============================
-- Colorscheme (AFTER plugins load)
-- ===============================
vim.cmd.colorscheme("tokyonight")

-- ===============================
-- IndentBlankline (v2) highlights
-- ===============================
vim.cmd([[highlight IndentBlanklineChar guifg=#3b4048]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#7f848e]])
