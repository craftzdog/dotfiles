if vim.loader then
	vim.loader.enable()
end

-- _G.dd = function(...)
--     require("util.debug").dump(...)
-- end
-- vim.print = _G.dd

_G.Craftzdog = require("craftzdog.utils")
require("craftzdog.config.options")
require("craftzdog.config.keymaps")
require("craftzdog.config.autocmds")
require("craftzdog.config.commands")
require("craftzdog.plugins")
