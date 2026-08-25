-- File explorer
require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		{ "permissions", highlight = "Type" },
		{ "size", highlight = "String" },
		{ "mtime", highlight = "Keyword" },
	},
	keymaps = {
		["h"] = { "actions.parent", mode = "n" },
		["q"] = { "actions.close", mode = "n" },
	},
	view_options = {
		show_hidden = true,
	},
	float = {
		padding = 8,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		max_width = 200,
	},
	preview_win = {
		update_on_cursor_moved = true,
	},
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
})

require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-l>",
			accept_word = "<M-l>",
			accept_line = "<M-S-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	filetypes = {
		markdown = true,
		help = true,
	},
})
