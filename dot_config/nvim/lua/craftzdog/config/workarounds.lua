-- Temporary workarounds for upstream bugs. Remove each once fixed upstream.

-- Workaround for neovim/neovim#40290: the treesitter fold module refreshes every
-- tracked buffer when 'foldminlines' is set, without checking the buffer is
-- still valid. codediff's compact mode sets it on each file switch, which
-- crashes with "Invalid buffer id" once a diff buffer has been wiped. Drop that
-- refresh autocmd; it only matters when changing foldminlines/foldnestmax.
require("vim.treesitter._fold")
for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "OptionSet" })) do
	if au.desc == "Refresh treesitter folds" then
		vim.api.nvim_del_autocmd(au.id)
	end
end
