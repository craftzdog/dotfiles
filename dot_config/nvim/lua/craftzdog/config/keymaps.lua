local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without updating the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<CR>")
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Toggle inlay hints
keymap.set("n", "<leader>i", function()
	-- require("craftzdog.lsp").toggleInlayHints()
end)

-- Yank current file path
keymap.set("n", "<leader>yf", function()
	local path = vim.fn.expand("%:.") .. ":" .. vim.fn.line(".")
	vim.fn.setreg("+", path)
	vim.notify("Yanked: " .. path, vim.log.levels.INFO)
end, { desc = "Yank relative path with line number" })

keymap.set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Yanked: " .. path, vim.log.levels.INFO)
end, { desc = "Yank absolute path" })

keymap.set("v", "<leader>cc", ":<C-u>lua require('craftzdog.utils.editor').copy_as_codeblock()<CR>")

keymap.set("n", "<leader>j", function()
	require("craftzdog.utils.editor").open_package_json()
end, { desc = "Open package.json in floating window" })

keymap.set("n", "<leader>bd", function()
	require("craftzdog.utils.editor").delete_hidden_buffers()
end, { desc = "Delete hidden buffers" })
