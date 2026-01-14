vim.o.swapfile = false
vim.o.smartcase = true
vim.o.gdefault = true

vim.o.number = true
vim.o.relativenumber = false

vim.cmd("com! CD cd %:p:h")
vim.cmd("com! LCD lcd %:p:h")
