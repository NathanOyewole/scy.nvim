local themes = require("themes")
local map = vim.keymap.set

-- ===============================
-- THEMES (themes.lua)
-- ===============================
map("n", "<leader>tn", themes.next, { desc = "Next colorscheme" })
map("n", "<leader>tp", themes.prev, { desc = "Previous colorscheme" })
map("n", "<leader>tc", function() themes.set("catppuccin") end, { desc = "Catppuccin" })
map("n", "<leader>tt", function() themes.set("tokyonight") end, { desc = "TokyoNight" })
map("n", "<leader>tg", function() themes.set("gruvbox") end, { desc = "Gruvbox" })
map("n", "<leader>tk", function() themes.set("kanagawa") end, { desc = "Kanagawa" })

-- ===============================
-- NORMAL MODE BASICS
-- ===============================
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ===============================
-- WINDOW NAVIGATION
-- ===============================
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Horizontal split" })

-- ===============================
-- TERMINAL (toggleterm.nvim)
-- ===============================
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", { desc = "Terminal Vertical" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })

-- Terminal mode keymaps
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Terminal window left" })
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Terminal window down" })
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Terminal window up" })
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Terminal window right" })

-- ===============================
-- FILE EXPLORER (Neo-tree)
-- ===============================
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Focus File Explorer" })

-- ===============================
-- TELESCOPE
-- ===============================
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

-- ===============================
-- LSP & GIT
-- ===============================
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover doc" })
map("n", "<leader>rn", ":IncRename ", { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>dl", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics list" })

map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })

-- ===============================
-- FORMATTING
-- ===============================
map("n", "<leader>f", function() require("conform").format({ async = true }) end, { desc = "Format file" })

-- ===============================
-- AI (CopilotChat)
-- ===============================
map("n", "<leader>cq", function()
  local ok, chat = pcall(require, "CopilotChat")
  if not ok then
    print("CopilotChat not loaded!")
    return
  end
  local input = vim.fn.input("Quick Question: ")
  if input ~= "" then chat.ask(input, { selection = require("CopilotChat.select").buffer }) end
end, { desc = "AI Quick Question" })

map("n", "<leader>ce", ":CopilotChatExplain<cr>", { desc = "AI Explain" })
map("n", "<leader>cf", ":CopilotChatFix<cr>", { desc = "AI Fix" })
map("n", "<leader>co", ":CopilotChatOptimize<cr>", { desc = "AI Optimize" })
map("n", "<leader>cr", ":CopilotChatReview<cr>", { desc = "AI Review" })
