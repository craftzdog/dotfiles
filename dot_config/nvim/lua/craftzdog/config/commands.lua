vim.api.nvim_create_user_command("ToggleFormatter", function()
	require("craftzdog.utils.editor").toggle_formatter()
end, { desc = "Toggle formatter for current buffer" })
