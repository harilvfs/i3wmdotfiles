require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>sr", ":SudaRead<CR>", { desc = "Suda Read (Open as sudo)" })
map("n", "<leader>sw", ":SudaWrite<CR>", { desc = "Suda Write (Save as sudo)" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- keybinding for formatting
map("n", "<leader>lf", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

-- ToggleTerm Keybindings
vim.api.nvim_create_autocmd("TermEnter", {
  pattern = "term://*toggleterm#*",
  command = 'tnoremap <silent><C-t> <Cmd>exe v:count1 .. "ToggleTerm"<CR>'
})

map("n", "<C-t>", function()
  local count = vim.v.count1 -- Get the count from Vim's API
  vim.cmd(count .. "ToggleTerm")
end, { desc = "Toggle Terminal" })

map("i", "<C-t>", function()
  local count = vim.v.count1
  vim.cmd("stopinsert | " .. count .. "ToggleTerm")
end, { desc = "Toggle Terminal (Insert Mode)" })

-- Normal mode: Move current line up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Visual mode: Move selected lines up/down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


