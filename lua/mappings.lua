require "nvchad.mappings"
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- REEMPLAZA LAS LÍNEAS DE LSPSAGA POR ESTAS:
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico de línea" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a la definición" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Acciones de código (Fixes)" })

-- Mapeo de la paleta visual solo para modo Normal (evita lag con la barra espaciadora)
vim.keymap.set("n", "<leader>p", "<cmd>CccPick<CR>", { desc = "Abrir paleta visual" })

local map = vim.keymap.set

-- Comando escrito en la consola: :Emojis
vim.api.nvim_create_user_command("Emojis", function()
  require("mis_emojis").abrir_selector()
end, {})

-- Atajo de teclado (Opcional pero recomendado)
-- Al presionar la tecla Líder (usualmente Espacio) seguida de 'e' y 'm' se abrirá la ventana
map("n", "<leader>em", function()
  require("mis_emojis").abrir_selector()
end, { desc = "Abrir selector de Emojis" })

-- Atajo para el modo insertar (Para no tener que salir a modo normal)
-- Presiona Ctrl + e mientras escribes código para abrir los emojis
map("i", "<C-e>", function()
  require("mis_emojis").abrir_selector()
end, { desc = "Abrir selector de Emojis" })
