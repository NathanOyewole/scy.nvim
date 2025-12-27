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
	vim.cmd.colorscheme(name)
	vim.notify("🎨 Theme: " .. name)
end

function M.next()
	M.index = M.index % #M.themes + 1
	M.set(M.themes[M.index])
end

function M.prev()
	M.index = (M.index - 2) % #M.themes + 1
	M.set(M.themes[M.index])
end

return M
