return {
  -- ===============================
  -- 0️⃣ Themes
  -- ===============================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
    end
  },
  { "folke/tokyonight.nvim",      config = function() require("tokyonight").setup({ style = "storm" }) end },
  { "ellisonleao/gruvbox.nvim",   config = function() require("gruvbox").setup({ contrast = "hard" }) end },
  { "navarasu/onedark.nvim",      config = function() require("onedark").setup({ style = "deep" }) end },
  { "sainnhe/everforest" },
  { "EdenEast/nightfox.nvim",     config = function() require("nightfox").setup({}) end },
  { "rebelot/kanagawa.nvim",      config = function() require("kanagawa").setup({}) end },
  { "shaunsingh/nord.nvim",       config = function() require("nord").set() end },
  { "NLKNguyen/papercolor-theme", priority = 1000 },
  { "bluz71/vim-moonfly-colors" },

  -- ===============================
  -- 1️⃣ Telescope
  -- ===============================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { preview_width = 0.55 },
          sorting_strategy = "ascending",
        },
      })
    end,
    keys = {
      { "<C-p>",      function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
    },
  },

  -- ===============================
  -- 2️⃣ Treesitter (Pinned to keep your config from breaking)
  -- ===============================
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- Locks onto the legacy branch so '.configs' works natively
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup({
          ensure_installed = { "lua", "javascript", "typescript", "bash", "json", "go", "rust" },
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
    cmd = "Neotree",
    keys = {
      { "<Space>n", "<cmd>Neotree toggle<cr>", desc = "Neotree Toggle" },
    },
    opts = {
      filesystem = {
        filtered_items = { hide_dotfiles = false, hide_gitignored = false },
        follow_current_file = { enabled = true },
      },
    },
  },

  -- ===============================
  -- 4️⃣ Dashboard (Alpha)
  -- ===============================
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "██╗  ██╗ ██████╗ ██╗    █████╗",
        "██║  ██║██╔═══██╗██║    ██╔══██╗",
        "██║  ██║██║   ██║██║    ███████║",
        "██║  ██║██║   ██║██║    ██╔══██║",
        "╚██████╔╝╚██████╔╝███████╗██║  ██║",
        " ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝",
        "",
        "        Welcome, bola!",
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "󰈞  Find File", ":Telescope find_files <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      alpha.setup(dashboard.opts)
    end,
  },

  -- ===============================
  -- 5️⃣ Formatter & QoL
  -- ===============================
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({ formatters_by_ft = { lua = { "stylua" }, javascript = { "prettier" } }, format_on_save = { timeout_ms = 500, lsp_fallback = true } })
    end
  },
  { "windwp/nvim-autopairs",   event = "InsertEnter", config = true },
  { "numToStr/Comment.nvim",   config = true },
  { "folke/which-key.nvim",    event = "VeryLazy",    config = true },

  -- ===============================
  -- 6️⃣ LSP & Autocomplete
  -- ===============================
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig")
          .setup({ ensure_installed = { "lua_ls", "ts_ls" } })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.ts_ls.setup({})
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "onsails/lspkind-nvim" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({ ["<CR>"] = cmp.mapping.confirm({ select = true }) }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "buffer" } }),
      })
    end,
  },

  -- ===============================
  -- 7️⃣ Git & Utilities
  -- ===============================
  { "lewis6991/gitsigns.nvim",   config = true },
  { "kdheepak/lazygit.nvim",     keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" } } },
  { "folke/trouble.nvim",        cmd = "Trouble",                                                                         config = true },
  { "rcarriga/nvim-notify",      config = function() vim.notify = require("notify") end },
  { "nvim-lualine/lualine.nvim", config = function() require("lualine").setup({ options = { theme = "catppuccin" } }) end },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({ open_mapping = [[<c-\>]] })
    end
  },
  { "kiddos/gemini.nvim", opts = { model_config = { model_id = 'gemini-2.5-flash' } } }
}
