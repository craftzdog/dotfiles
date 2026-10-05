---@type vim.lsp.Config
return {
	single_file_support = true,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			misc = {
				parameters = {
					-- "--log-level=trace",
				},
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			doc = {
				privateName = { "^_" },
			},
			type = {
				castNumberToInteger = true,
			},
			diagnostics = {
				disable = { "incomplete-signature-doc", "trailing-space" },
				-- enable = false,
				groupSeverity = {
					strong = "Warning",
					strict = "Warning",
				},
				groupFileStatus = {
					["ambiguity"] = "Opened",
					["await"] = "Opened",
					["codestyle"] = "None",
					["duplicate"] = "Opened",
					["global"] = "Opened",
					["luadoc"] = "Opened",
					["redefined"] = "Opened",
					["strict"] = "Opened",
					["strong"] = "Opened",
					["type-check"] = "Opened",
					["unbalanced"] = "Opened",
					["unused"] = "Opened",
				},
				unusedLocalExclude = { "_*" },
			},
		},
	},
}
