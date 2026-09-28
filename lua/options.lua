require "nvchad.options"

vim.opt.autochdir = true

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'php',
  },
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    vim.fn.jobstart({ "paplay", "--volume=40000", "/home/pc/.sonido2.wav" }, { detach = true })
  end,
})

-- 1. Forzar el cursor en modo bloque y asignarle los colores
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-CursorInsert,r-cr-o:block-Cursor"

-- 2. Forzar la terminal a usar el color negro puro (Clonando el fondo de NvimTree)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("setlocal winhighlight=Normal:NvimTreeNormal,NormalNC:NvimTreeNormal")
  end,
})

-- 3. Inyectar el color a la terminal de Ubuntu para que no bloquee el rojo/verde
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  callback = function()
    io.write("\27]12;#8a0303\7")
  end,
})

vim.api.nvim_create_autocmd({"InsertLeave", "VimEnter"}, {
  callback = function()
    io.write("\27]12;#8da336\7")
  end,
})

vim.api.nvim_create_autocmd({"VimLeave"}, {
  callback = function()
    io.write("\27]112\7")
  end,
})
