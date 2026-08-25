gh = function(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	-- UI
	{ src = gh("craftzdog/solarized-osaka.nvim") },
	{ src = gh("nvim-mini/mini.icons") },
	{ src = gh("folke/snacks.nvim") },
	{ src = gh("folke/trouble.nvim") },
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("b0o/incline.nvim") },
	{ src = gh("esmuellert/codediff.nvim") },
	{ src = gh("rachartier/tiny-cmdline.nvim") },
	-- Editor
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("nvim-mini/mini.pairs") },
	{ src = gh("craftzdog/mini.diff"), version = "feat/grouping" },
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("^1") },
	{ src = gh("folke/todo-comments.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("linrongbin16/gitlinker.nvim") },
	{ src = gh("brenoprata10/nvim-highlight-colors") },
	-- LSP
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	-- Util
	{ src = gh("stevearc/oil.nvim") },
	{ src = gh("zbirenbaum/copilot.lua") },
})

if #vim.api.nvim_get_runtime_file("lua/craftzdog/plugins/local.lua", false) > 0 then
	require("craftzdog.plugins.local")
end

require("craftzdog.plugins.ui")
require("craftzdog.plugins.treesitter")
require("craftzdog.plugins.editor")
require("craftzdog.plugins.lsp")
require("craftzdog.plugins.util")
require("craftzdog.plugins.keymaps")
