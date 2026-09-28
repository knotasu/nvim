---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  hl_override = {
    -- Fondo principal del editor (Verde Militar Oscuro que elegiste)
    Normal = { bg = "#0C0F0C" },
    NormalNC = { bg = "#121711" },
    
    -- Fondo del menú de carpetas lateral (Totalmente Negro)
    NvimTreeNormal = { bg = "#000000" },
    NvimTreeNormalNC = { bg = "#000000" },
    NvimTreeEndOfBuffer = { bg = "#000000", fg = "#000000" },
    
    -- Cursor tipo Counter Strike 1.6 (Verde militar brillante)
    Cursor = { bg = "#950606", fg = "#000000" },
    
    -- Cursor MODO INSERT (Rojo sangre profundo)
    CursorInsert = { bg = "#ffffff", fg = "#ffffff" },

    -- RESALTADO DE VARIABLES IGUALES (LSP)
    -- Puedes cambiar este código hexadecimal por otro si lo ves muy claro o muy oscuro
    LspReferenceText = { bg = "#252B25" },
    LspReferenceRead = { bg = "#252B25" },
    LspReferenceWrite = { bg = "#252B25" },
  } ,
}

M.ui = {
  icons = {
    ft = "󰮋", 
  }
}

return M
