return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css", "javascript", "php", "svelte", "blade", "xml", "java", "kotlin", "cpp", "c" },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          --nuevo para el escojer el autocompletado
          vim.fn.jobstart({"paplay", "--volume=32768", "/home/pc/.sonido1.wav"}, { detach = true })
          -- Si el menú se ve, selecciona la opción directamente (sin sonar)
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
        else
          -- Si no hay menú abierto, hace el salto de línea y suena
          vim.fn.jobstart({ "paplay", "--volume=32768","/home/pc/.sonido.wav" }, { detach = true })
          fallback()
        end
      end, { "i", "s" })
      return opts
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end,
  },
{
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
    config = function()
      require("ccc").setup()
    end,
  },
}
