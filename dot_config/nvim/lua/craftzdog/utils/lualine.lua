---@class utils.lualine
local M = {}

-- Root detection markers (similar to LazyVim)
local root_patterns = { ".git", "lua", "package.json", "Makefile", "Cargo.toml", "go.mod", "pyproject.toml" }

--- Get the current working directory (normalized)
---@return string
local function get_cwd()
	return vim.uv.cwd() or vim.fn.getcwd()
end

--- Normalize a path (resolve symlinks, ensure consistent format)
---@param path string
---@return string
local function normalize(path)
	if path:sub(1, 1) == "~" then
		path = vim.fn.expand(path)
	end
	path = vim.uv.fs_realpath(path) or path
	return path:gsub("/$", "")
end

--- Find the project root directory
---@return string
local function get_root()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		path = get_cwd()
	end
	path = vim.fs.dirname(path)

	-- Try to find root using vim.fs.find
	local root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
	if root then
		return normalize(vim.fs.dirname(root))
	end

	-- Fallback to cwd
	return normalize(get_cwd())
end

--- ⏺ The pretty_path function (lines 82-149) creates a lualine component that displays the current file path in a formatted, condensed way. Here's what it does:
--
-- Options (with defaults):
-- - relative: "cwd" or "root" - determines what the path is relative to
-- - modified_hl: "MatchParen" - highlight group for modified files
-- - directory_hl: "" - highlight group for directory portion
-- - filename_hl: "Bold" - highlight group for filename
-- - modified_sign: "" - symbol appended to modified files
-- - readonly_icon: " 󰌾 " - icon shown for readonly files
-- - length: 3 - max number of path segments to show
--
-- Behavior:
--
-- 1. Makes path relative - Strips the cwd or project root prefix from the absolute path, showing only the relevant portion
-- 2. Truncates long paths - If the path has more segments than length, it shows the first segment, an ellipsis (…), then the last segments. For example: src/…/components/Button.lua
-- 3. Applies highlighting - Different highlight groups for:
--   - Directory portion (dimmer by default)
--   - Filename (bold by default)
--   - Modified files (uses MatchParen highlight)
-- 4. Shows indicators - Appends a modified sign if the buffer is modified, and a readonly icon if the buffer is readonly
-- 5. Windows compatibility - Handles case-insensitive path matching on Windows

---@param opts? {relative: "cwd"|"root", modified_hl: string?, directory_hl: string?, filename_hl: string?, modified_sign: string?, readonly_icon: string?, length: number?}
function M.pretty_path(opts)
	opts = vim.tbl_extend("force", {
		relative = "cwd",
		modified_hl = "MatchParen",
		directory_hl = "",
		filename_hl = "Bold",
		modified_sign = "",
		readonly_icon = " 󰌾 ",
		length = 3,
	}, opts or {})

	return function(self)
		local path = vim.fn.expand("%:p") --[[@as string]]

		if path == "" then
			return ""
		end

		-- Normalize path
		path = normalize(path)

		-- Make path relative
		local cwd = normalize(get_cwd())
		local root = opts.relative == "root" and get_root() or cwd

		-- Case-insensitive matching on Windows
		local path_lower = path:lower()
		local root_lower = root:lower()
		if vim.fn.has("win32") == 1 then
			if path_lower:find(root_lower, 1, true) == 1 then
				path = path:sub(#root + 2)
			end
		else
			if path:find(root, 1, true) == 1 then
				path = path:sub(#root + 2)
			end
		end

		-- Split path into segments
		local sep = package.config:sub(1, 1)
		local parts = vim.split(path, "[\\/]")

		-- Truncate if too many segments (when length > 0)
		if opts.length > 0 and #parts > opts.length then
			local truncated = { parts[1], "…" }
			for i = #parts - opts.length + 2, #parts do
				table.insert(truncated, parts[i])
			end
			parts = truncated
		end

		-- Separate directory and filename
		local filename = parts[#parts]
		local dir = ""
		if #parts > 1 then
			dir = table.concat(vim.list_slice(parts, 1, #parts - 1), sep) .. sep
		end

		-- Build the formatted string with highlights
		local hl_group = "lualine_c_normal"
		if self and self.options and self.options.section then
			hl_group = "lualine_" .. self.options.section .. "_normal"
		end

		-- Apply directory highlight
		local dir_hl = opts.directory_hl ~= "" and opts.directory_hl or nil
		local dir_part = dir_hl and ("%#" .. dir_hl .. "#" .. dir .. "%#" .. hl_group .. "#") or dir

		-- Check if modified
		local modified = vim.bo.modified
		local readonly = vim.bo.readonly or not vim.bo.modifiable

		-- Apply filename highlight (modified takes precedence)
		local file_hl = modified and opts.modified_hl or opts.filename_hl
		local file_part = file_hl and file_hl ~= "" and ("%#" .. file_hl .. "#" .. filename .. "%#" .. hl_group .. "#")
			or filename

		-- Build result
		local result = dir_part .. file_part

		-- Add modified sign
		if modified and opts.modified_sign ~= "" then
			result = result .. opts.modified_sign
		end

		-- Add readonly icon
		if readonly then
			result = result .. opts.readonly_icon
		end

		return result
	end
end

-- ⏺ The root_dir function (lines 152-193) creates a lualine component that displays the project root directory name with configurable visibility based on its relationship to the current working directory.
--
--   Options (with defaults):
--   - cwd: false - show when root equals cwd
--   - subdirectory: true - show when root is a subdirectory of cwd
--   - parent: true - show when root is a parent of cwd
--   - other: true - show when root and cwd are unrelated
--   - icon: "󱉭 " - icon displayed before the directory name
--   - color: function returning Special highlight color
--
--   Behavior:
--
--   1. Determines relationship between the project root and cwd, then decides whether to show the component based on that relationship:
--     - root == cwd: Only shows if opts.cwd is true
--     - root is inside cwd (e.g., cwd=~/projects, root=~/projects/myapp): Shows if opts.subdirectory is true
--     - root is parent of cwd (e.g., cwd=~/projects/myapp/src, root=~/projects/myapp): Shows if opts.parent is true
--     - unrelated paths: Shows if opts.other is true
--   2. Returns a lualine component table with:
--     - A function that renders the icon + directory basename
--     - A cond function that hides the component when the relationship option is disabled
--     - The configured color
--
--   Use case: This lets you show the project root name in your statusline only in certain situations—for example, hiding it when you're already at the root (since it's obvious), but showing it when you've cd'd into a subdirectory.
---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
function M.root_dir(opts)
	opts = vim.tbl_extend("force", {
		cwd = false,
		subdirectory = true,
		parent = true,
		other = true,
		icon = "󱉭 ",
		color = function()
			return { fg = Snacks.util.color("Special") }
		end,
	}, opts or {})

	local function get()
		local cwd = normalize(get_cwd())
		local root = get_root()
		local name = vim.fs.basename(root)

		if root == cwd then
			-- root is cwd
			return opts.cwd and name
		elseif root:find(cwd, 1, true) == 1 then
			-- root is subdirectory of cwd
			return opts.subdirectory and name
		elseif cwd:find(root, 1, true) == 1 then
			-- root is parent directory of cwd
			return opts.parent and name
		else
			-- root and cwd are not related
			return opts.other and name
		end
	end

	return {
		function()
			return (opts.icon and opts.icon .. " ") .. get()
		end,
		cond = function()
			return type(get()) == "string"
		end,
		color = opts.color,
	}
end

return M
