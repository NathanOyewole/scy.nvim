return {

	-- ===============================
	-- 0️⃣ Theme
	-- ===============================
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup()
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- ===============================
	-- 1️⃣ Telescope
	-- ===============================
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<C-p>",
				function()
					require("telescope.builtin").find_files()
				end,
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits()
				end,
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches()
				end,
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status()
				end,
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
			if not ok then
				return
			end
			configs.setup({
				ensure_installed = { "lua", "javascript", "typescript", "bash", "json" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- ===============================
	-- 3️⃣ Neo-tree
	-- ===============================
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- ===============================
	-- 6️⃣ Comment toggling
	-- ===============================
	{
		"numToStr/Comment.nvim",
		config = true,
	},

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
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "jsonls", "bashls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
			lspconfig.tsserver.setup({})
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
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
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
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	-- ===============================
	-- 🔥 Extra QoL Plugins
	-- ===============================

	-- Trouble for diagnostics list
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({ signs = true, use_diagnostic_signs = true })
		end,
	},

	-- Fidget for LSP progress
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup({})
		end,
	},

	-- Colorizer for highlighting hex/rgb colors
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Notify for nicer notifications
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
}
