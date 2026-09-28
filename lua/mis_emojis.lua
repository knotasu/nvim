local M = {}

-- Aquí puedes agregar todas las categorías y emojis que quieras
M.categorias = {
Caras = {
    "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃", "🫠",
    "😉", "😊", "😇", "🥰", "😍", "🤩", "😘", "😗", "☺️", "😚",
    "😙", "🥲", "😋", "😛", "😜", "🤪", "😝", "🤑", "🤗", "🤭",
    "🫢", "🫣", "🤫", "🤔", "🫡", "🤐", "🤨", "😐", "😑", "😶",
    "🫥", "😶‍🌫️", "😏", "😒", "🙄", "😬", "😮‍💨", "🤥", "🫨", "🙂‍↔️",
    "🙂‍↕️", "😌", "😔", "😪", "🤤", "😴", "🫩", "😷", "🤒", "🤕",
    "🤢", "🤮", "🤧", "🥵", "🥶", "🥴", "😵", "😵‍💫", "🤯", "🤠",
    "🥳", "🥸", "😎", "🤓", "🧐", "😕", "🫤", "😟", "🙁", "☹️",
    "😮", "😯", "😲", "😳", "🥺", "🥹", "😦", "😧", "😨", "😰",
    "😥", "😢", "😭", "😱", "😖", "😣", "😞", "😓", "😩", "😫",
    "🥱", "😤", "😡", "😠", "🤬", "😈", "👿", "💀", "☠️", "💩",
    "🤡", "👹", "👺", "👻", "👽", "👾", "🤖", "😺", "😸", "😹",
    "😻", "😼", "😽", "🙀", "😿", "😾", "🙈", "🙉", "🙊"
  },
  Corazones = { "🖤", "🩶", "🤍", "❤️", "💙", "💌", "💘", "💝", "💖", 
                "💗", "💓", "💞", "💟", "❣️", "💔", "🩷", "🧡", "💛",
                "💚",},
  Manos = { "👍", "👎", "✌️", "👏", "🙌" }
}

function M.abrir_selector()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  -- Preparamos la lista de categorías
  local cat_keys = {}
  for k, _ in pairs(M.categorias) do table.insert(cat_keys, k) end

  -- AQUI ESTÁ LA MAGIA: Configuramos una ventana pequeña tipo "cursor"
  local opciones_ventana = themes.get_cursor({
    layout_config = {
      width = 25,  -- Ancho del rectángulo (bastante estrecho)
      height = 12, -- Alto (cantidad de elementos que ves a la vez)
    },
    prompt_title = false,  -- Oculta el título para ahorrar espacio
    results_title = false,
  })

  -- Ventana 1: Seleccionar la categoría
  pickers.new(opciones_ventana, {
    prompt_title = "Categorías",
    finder = finders.new_table { results = cat_keys },
    sorter = conf.generic_sorter(opciones_ventana),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local seleccion = action_state.get_selected_entry()
        if not seleccion then return end
        local categoria = seleccion[1]

        local emojis_list = M.categorias[categoria]
        
        -- Ventana 2: Seleccionar el emoji de esa categoría
        pickers.new(opciones_ventana, {
          prompt_title = categoria,
          finder = finders.new_table { results = emojis_list },
          sorter = conf.generic_sorter(opciones_ventana),
          attach_mappings = function(prompt_bufnr2, map2)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr2)
              local emoji_seleccionado = action_state.get_selected_entry()
              if not emoji_seleccionado then return end
              
              -- Insertar el emoji en la posición del cursor
              vim.api.nvim_put({emoji_seleccionado[1]}, "c", false, true)
            end)
            return true
          end,
        }):find()
      end)
      return true
    end,
  }):find()
end
return M
