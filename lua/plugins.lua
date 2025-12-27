return {

	-- ===============================
	-- 0️⃣ Theme
	-- ===============================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({ flavour = "mocha" })
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({ style = "storm" })
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({ contrast = "hard" })
		end,
	},
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({ style = "deep" })
		end,
	},
	{ "sainnhe/everforest" },
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({})
		end,
	},
	{
		"shaunsingh/nord.nvim",
		config = function()
			require("nord").set()
		end,
	},
	{ "NLKNguyen/papercolor-theme" },
	{ "bluz71/vim-moonfly-colors" },

	-- ===============================
	-- 1️⃣ Telescope
	-- ===============================
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = { preview_width = 0.55 },
					sorting_strategy = "ascending",
					winblend = 0,
				},
			})
		end,
		keys = {
			{
				"<C-p>",
				function()
					require("telescope.builtin").find_files()
				end,
				mode = "n",
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				mode = "n",
				desc = "Live grep",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				mode = "n",
				desc = "Buffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				mode = "n",
				desc = "Help tags",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits()
				end,
				mode = "n",
				desc = "Git commits",
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches()
				end,
				mode = "n",
				desc = "Git branches",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status()
				end,
				mode = "n",
				desc = "Git status",
			},
		},
	},

	-- ===============================
	-- 2️⃣ Treesitter
	-- ===============================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local ok, configs = pcall(require, "nvim-treesitter.configs")
			if ok then
				configs.setup({
					ensure_installed = { "lua", "javascript", "typescript", "bash", "json" },
					highlight = { enable = true },
					indent = { enable = true },
				})
			end
		end,
	},

	-- ===============================
	-- 3️⃣ Neo-tree
	-- ===============================
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		keys = {
			{
				"<Space>e",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
			},
			{
				"<Space>f",
				function()
					require("neo-tree.command").execute({ focus = true })
				end,
			},
			{
				"<Space>r",
				function()
					require("neo-tree.command").execute({ reveal = true })
				end,
			},
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				filesystem = {
					filtered_items = { hide_dotfiles = false, hide_gitignored = false },
					follow_current_file = { enabled = true, leave_dirs_open = false },
					use_libuv_file_watcher = true,
				},
				window = {
					position = "left",
					width = 35,
					mapping_options = { noremap = true, nowait = true },
					mappings = {
						["<CR>"] = "open",
						["o"] = "open",
						["<C-n>"] = "open_with_window_picker",
						["s"] = "split_with_window_picker",
						["v"] = "vsplit_with_window_picker",
						["h"] = "close_node",
						["H"] = "collapse_all_nodes",
						["l"] = "expand_node",
						["L"] = "expand_all_nodes",
						["R"] = "refresh",
						["a"] = "add",
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
					},
				},
			})
		end,
	},

	-- ===============================
	-- 4️⃣ Formatter
	-- ===============================
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
				},
				format_on_save = { timeout_ms = 500, lsp_fallback = true },
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					require("conform").format({ async = false })
				end,
			})
		end,
	},

	-- ===============================
	-- 5️⃣ Auto pairs
	-- ===============================
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },

	-- ===============================
	-- 6️⃣ Comment toggling
	-- ===============================
	{ "numToStr/Comment.nvim", config = true },

	-- ===============================
	-- 7️⃣ Which-key
	-- ===============================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup()
		end,
	},

	-- ===============================
	-- 8️⃣ LSP & Autocomplete
	-- ===============================
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "ts_ls", "jsonls", "bashls" } })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
			lspconfig.ts_ls.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.bashls.setup({})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				formatting = { format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }) },
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- ===============================
	-- 9️⃣ Git Integration
	-- ===============================
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
			})
		end,
	},
	{ "kdheepak/lazygit.nvim", cmd = "LazyGit" },

	-- ===============================
	-- 🔥 Extra QoL Plugins
	-- ===============================
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({ signs = true, use_diagnostic_signs = true })
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	-- ===============================
	-- 🔥 NEW Plugins fully configured
	-- ===============================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({ options = { theme = "catppuccin" } })
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"██╗   ██╗ ██████╗ ██╗      █████╗",
				"██║   ██║██╔═══██╗██║     ██╔══██╗",
				"██║   ██║██║   ██║██║     ███████║",
				"██║   ██║██║   ██║██║     ██╔══██║",
				"╚██████╔╝╚██████╔╝███████╗██║  ██║",
				" ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝",
				"",
				"        Welcome, bola!",
			}
			alpha.setup(dashboard.opts)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<c-\>]],
				shade_terminals = true,
				direction = "horizontal",
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({ bind = true, floating_window = true, hint_enable = true })
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},

	-- ===============================
	-- 🔹 Indent-Blankline (after Treesitter)
	-- ===============================
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "2.20.8",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
		config = function()
			require("indent_blankline").setup({
				char = "│",
				show_trailing_blankline_indent = true,
				show_current_context = true,
				show_current_context_start = true,
				use_treesitter = true,
				filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "toggleterm" },
				buftype_exclude = { "terminal", "nofile" },
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "IndentBlanklineReady",
				callback = function()
					vim.cmd([[highlight IndentBlanklineChar guifg=#3b4048]])
					vim.cmd([[highlight IndentBlanklineContextChar guifg=#7f848e]])
				end,
			})
		end,
	},
}
