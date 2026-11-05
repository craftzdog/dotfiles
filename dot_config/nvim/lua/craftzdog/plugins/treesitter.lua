local TS = require("nvim-treesitter")

if vim.fn.has("win32") == 1 and vim.fn.executable("cl.exe") == 0 then
	vim.env.CC = "gcc"
end

local ensure_installed = {
	"astro",
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"fish",
	"gitignore",
	"go",
	"graphql",
	"html",
	"http",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"php",
	"printf",
	"python",
	"query",
	"regex",
	"rust",
	"scss",
	"sql",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

local function install_parsers()
	TS.install(ensure_installed)
end

-- Wait for mason-tool-installer to finish before compiling parsers
if vim.fn.executable("tree-sitter") == 1 then
	install_parsers()
else
	vim.api.nvim_create_autocmd("User", {
		pattern = "MasonToolsUpdateCompleted",
		once = true,
		callback = install_parsers,
	})
end

require("treesitter-autoinstall").setup()

-- MDX has no parser of its own; render it with the Markdown one.
vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})
vim.treesitter.language.register("markdown", "mdx")

local treesitter_group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Hook
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		vim.cmd("TSUpdate")
	end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
