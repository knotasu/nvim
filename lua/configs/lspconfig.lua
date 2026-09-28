local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

-- Sacamos a 'clangd' de esta lista general para configurarlo aparte
local servers = { "cssls", "intelephense", "svelte", "lemminx", "kotlin_language_server" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Configuración específica para C++ para que lea <iostream> en Ubuntu
lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--query-driver=/usr/bin/g++,/usr/bin/gcc" -- ¡Esta es la magia que lo soluciona!
  }
}

lspconfig.html.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "php" }, 
}
