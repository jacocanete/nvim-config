-- Everything here is to make it so that my current NVIM setup fits how my dev environment is setup  for DI

return {
  -- for mason to auto install my shit
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "eslint_d", -- for linting js, ts
        "stylua", -- for lua
        -- "stylelint", -- for css and scss linting
        "phpcs", -- for php diagnostics
        "phpcbf", -- for php code formatting
        "typescript-language-server", -- I use this for TS diagnostics
        "lua-language-server",
        "emmet-language-server",
        "css-variables-language-server",
        "stylelint-lsp",
      },
    },
  },
  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "luasnip" })
    end,
  },
  -- formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "phpcbf" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      },
    },
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        php = { "phpcs" },
      },
    },
  },
  -- treesitter
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
        "css",
        "scss",
        "php",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylelint_lsp = {
          settings = {
            stylelintplus = {
              autoFixOnSave = true,
            },
          },
          filetypes = { "css", "scss" },
        },
        tsserver = {},
        emmet_language_server = {
          filetypes = { "php", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        },
      },
      setup = {
        tsserver = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
}
