local themes = require("themes")

-- Next theme
vim.keymap.set("n", "<leader>tn", themes.next, {
	desc = "Next colorscheme",
})

-- Previous theme
vim.keymap.set("n", "<leader>tp", themes.prev, {
	desc = "Previous colorscheme",
})

-- Direct picks
vim.keymap.set("n", "<leader>tc", function()
	themes.set("catppuccin")
end, { desc = "Catppuccin" })

vim.keymap.set("n", "<leader>tt", function()
	themes.set("tokyonight")
end, { desc = "TokyoNight" })

vim.keymap.set("n", "<leader>tg", function()
	themes.set("gruvbox")
end, { desc = "Gruvbox" })

vim.keymap.set("n", "<leader>tk", function()
	themes.set("kanagawa")
end, { desc = "Kanagawa" })
