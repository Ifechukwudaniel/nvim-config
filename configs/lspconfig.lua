local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.noir_lsp then
  configs.noir_lsp = {
    default_config = {
      cmd = { 'nargo', '--lsp' },
      root_dir = lspconfig.util.root_pattern('Nargo.toml'),
      filetypes = { 'noir', 'nr' },
    },
  }
end
lspconfig.noir_lsp.setup {}

local on_attach = require("custom.configs.lsp").on_attach
local capabilities = require("custom.configs.lsp").capabilities

local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  -- Enable virtual text
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
)


local mason_lspconfig = require "mason-lspconfig"

local disabled_servers = {
  "jdtls",
}

mason_lspconfig.setup_handlers {
  function(server_name)
    for _, name in pairs(disabled_servers) do
      if name == server_name then
        return
      end
    end
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    local require_ok, server = pcall(require, "custom.configs.lsp.settings." .. server_name)
    if require_ok then
      opts = vim.tbl_deep_extend("force", server, opts)
    end

    require("lspconfig")[server_name].setup(opts)
  end,
}
