vim.keymap.set("n", "Q", "@")
vim.keymap.set({ "n", "x" }, "m", "d")
vim.keymap.set("n", "mm", "dd")
vim.keymap.set("n", "M", "D")

vim.keymap.set("n", "<leader>fw", "<cmd>%s/\\s\\+$//<CR>:let @/=''<cr>", { desc = "File Whitespace" })
vim.keymap.set("v", "<leader>fw", "<cmd>'<,'>s/\\s\\+$//<CR>:let @/=''<cr>", { desc = "File Whitespace" })

if not vim.g.vscode then
  vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "File Save" })

  -- vim.keymap.set(
  --   "n",
  --   "<leader>ss",
  --   require("telescope.builtin").current_buffer_fuzzy_find,
  --   { desc = "[S]earch in current buffer" }
  -- )
end

if vim.g.vscode then
  local nmap = function(keys, func)
    vim.keymap.set("n", keys, func, { silent = true, remap = false })
  end

  nmap("<leader>fs", "<Cmd>call VSCodeNotify('workbench.action.files.save')<CR>")

  nmap(
    "<leader>fi",
    "<Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>:<C-u>call VSCodeNotify('editor.action.organizeImports')<CR>"
  )
  nmap("K", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>")
  -- nmap("gd", "<Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>")
  -- nmap("gD", "<Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>")
end
