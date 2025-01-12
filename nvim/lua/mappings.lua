require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>sr", ":SudaRead<CR>", { desc = "Suda Read (Open as sudo)" })
map("n", "<leader>sw", ":SudaWrite<CR>", { desc = "Suda Write (Save as sudo)" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
