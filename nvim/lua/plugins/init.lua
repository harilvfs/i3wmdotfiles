return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

    -- Quick word search under cursor
  {
    "RRethy/vim-illuminate",
    lazy = false,
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({})
    end,
  },

    -- Clipboard image plugin
  {
    "postfen/clipboard-image.nvim",
    lazy = false,
    config = function()
      require("clipboard-image").setup({
        default = {
          img_dir = "images",
          img_dir_txt = "images",
          affix = "![](%s)",
        },
      })
    end,
  },

    -- Undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

    -- Wakatime
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

    -- Auto save
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    event = "InsertEnter",
    config = function()
      require("auto-save").setup({})
    end,
  },

    -- True Zen mode
  {
    "Pocco81/true-zen.nvim",
    cmd = "TZFocus",
  },

    -- Suda plugin for editing files as sudo
  {
    "lambdalisue/suda.vim",
    lazy = false,
    -- Optional: Add configuration if needed
    config = function()
      vim.g.suda_smart_edit = 1 -- Example configuration for suda
    end,
  },

    -- Synthwave84 theme
  {
    "lunarvim/synthwave84.nvim",
    config = function()
      require("synthwave84").setup({})
    end,
  },

    -- GitHub Copilot
  {
    "github/copilot.vim",
    lazy = false,
    event = "InsertEnter",
  },

    -- Rust support
  {
    "rust-lang/rust.vim",
    lazy = false,
    ft = "rust",
  },

    -- Clang autocompletion
  {
    "deoplete-plugins/deoplete-clang",
    lazy = false,
  },

    -- Null-ls for diagnostics and formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("null-ls").setup()
    end,
  },

    -- Tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

    -- Markview for markdown preview
  {
    "OXY2DEV/markview.nvim",
    lazy = false,      -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
  },

    -- Dropbar for breadcrumbs
  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    config = function()
      require("dropbar").setup({})
    end,
  },

  {
    "wurli/visimatch.nvim",
    lazy = false,
    opts = {}
  },

  {
    "z0mbix/vim-shfmt",
    lazy=false,
  },

  {
    "rachartier/tiny-glimmer.nvim",
    lazy = false,
    event = "VeryLazy",
    opts = {
        -- your configuration
    },
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  }
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  }
