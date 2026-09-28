require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require("jdtls")
    -- Creamos un workspace limpio por cada proyecto
    local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    
    -- Forzamos la ruta absoluta del ejecutable de Mason para evitar fallos de PATH
    local jdtls_bin = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")
    
    local config = {
      cmd = { jdtls_bin, "-data", workspace_dir },
      root_dir = require("lspconfig.util").root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle") or vim.fn.getcwd(),
    }
    
    -- Iniciamos el servidor de forma segura
    jdtls.start_or_attach(config)
  end,
})

-- lua/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Creamos un grupo para evitar que el evento se duplique al recargar Neovim
local lsp_document_highlight = augroup("lsp_document_highlight", { clear = true })

-- Acción 1: Ilumina las variables iguales cuando el cursor se queda quieto (Hold)
autocmd({ "CursorHold", "CursorHoldI" }, {
  group = lsp_document_highlight,
  callback = function()
    -- Solo ejecuta si hay un servidor de lenguaje (LSP) activo
    if next(vim.lsp.get_clients()) ~= nil then
      pcall(vim.lsp.buf.document_highlight)
    end
  end,
})

-- Acción 2: Limpia el resaltado en cuanto mueves el cursor
autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = lsp_document_highlight,
  callback = function()
    if next(vim.lsp.get_clients()) ~= nil then
      pcall(vim.lsp.buf.clear_references)
    end
  end,
})
