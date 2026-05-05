return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local servers = {
      "lua_ls",        -- Lua
      "pyright",       -- Python
      "clangd",        -- C/C++
      "rust_analyzer", -- Rust
      "bashls",        -- Bash
      "jsonls",        -- JSON
      "yamlls",        -- YAML
    }

    for _, server in ipairs(servers) do
      local opts = {}

      if server == "clangd" then
        opts = {
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        }
      end

      lspconfig[server].setup(opts)
    end
  end
  },

  {
  "williamboman/mason.nvim",
  lazy = false,
  config = function()
    require("mason").setup()
  end
  },

  {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {  -- Add more languages as needed
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "clangd",        -- C/C++
        "rust_analyzer", -- Rust
        "bashls",        -- Bash
        "jsonls",        -- JSON
        "yamlls",        -- YAML
      },
      automatic_installation = true,
    })
  end
  },

  {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier, -- JS, HTML, CSS
        null_ls.builtins.formatting.black,    -- Python
        null_ls.builtins.formatting.stylua,   -- Lua
        null_ls.builtins.formatting.shfmt,    -- Bash
      }
    })
  end
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
  },

  {
  "rachartier/tiny-inline-diagnostic.nvim",
  lazy = false,
  event = "LspAttach",  -- Load only when LSP starts
  config = function()
    require('tiny-inline-diagnostic').setup({
      highlight = "DiagnosticVirtualTextError", -- Adjust highlight group
      prefix = "⚠ ", -- Add a prefix if needed
    })
    vim.diagnostic.config({ virtual_text = false }) -- Disable native inline diagnostics
  end
  },

---@type LazySpec
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    -- check the installation instructions at
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim"
  },
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<c-up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
},

  {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  config = function()
    require("toggleterm").setup({
      float_opts = {
        border = "rounded",
        winblend = 0,  -- Keep transparency minimal
        highlights = {
          background = "NormalFloat",
        },
      },
      shade_terminals = false, -- Prevents unwanted shading
    })

    -- Force floating terminal background to match normal editor background
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  end
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
