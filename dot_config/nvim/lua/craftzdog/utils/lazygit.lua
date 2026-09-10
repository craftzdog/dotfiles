local M = {}

--- Window from which lazygit was launched. Files opened from inside lazygit
--- (`e`) are edited here, so they reuse the focused pane instead of landing in
--- a new tab or the first window. Paired with the `os.edit` override in
--- craftzdog/plugins/ui.lua.
local origin_win = nil

--- Opens lazygit, remembering the currently focused window as the target for
--- files opened from within it.
function M.open()
	origin_win = vim.api.nvim_get_current_win()
	Snacks.lazygit()
end

--- Focuses the window lazygit was launched from so the following
--- `nvim --remote <file>` edits there. Called from the `os.edit` command built
--- below. No-op when the origin window is gone (e.g. closed while lazygit was
--- open), letting `--remote` fall back to the current window.
function M.focus_origin()
	if origin_win and vim.api.nvim_win_is_valid(origin_win) then
		pcall(vim.api.nvim_set_current_win, origin_win)
	end
end

-- Talks to the neovim instance that launched lazygit ($NVIM is its RPC socket).
local nvim_server = 'nvim --server "$NVIM"'

-- Refocus the launch pane from inside lazygit's terminal. `<Cmd>` runs in any
-- mode, and long brackets keep the single/double quotes free of escaping.
local focus_launch_pane = nvim_server
	.. [[ --remote-send '<Cmd>lua require("craftzdog.utils.lazygit").focus_origin()<CR>']]

--- Builds a lazygit `os.edit` / `os.editAtLine` command (fish syntax) that opens
--- the selected file in the pane lazygit was launched from rather than a new
--- tab. lazygit fills in `{{filename}}` (shell-quoted) and `{{line}}`.
--- @param opts? { at_line?: boolean } also jump to `{{line}}` after opening
--- @return string
function M.edit_command(opts)
	local at_line = opts and opts.at_line

	-- No $NVIM: lazygit was launched outside neovim, so just edit directly.
	local outside_neovim = at_line and "nvim +{{line}} -- {{filename}}" or "nvim -- {{filename}}"

	-- Inside neovim: quit lazygit, return to the launch pane, open the file there.
	local inside_neovim = {
		nvim_server .. ' --remote-send "q"',
		focus_launch_pane,
		nvim_server .. " --remote {{filename}}",
	}
	if at_line then
		inside_neovim[#inside_neovim + 1] = nvim_server .. ' --remote-send ":{{line}}<CR>"'
	end

	return ('begin; if test -z "$NVIM"; %s; else; %s; end; end'):format(
		outside_neovim,
		table.concat(inside_neovim, "; ")
	)
end

return M
