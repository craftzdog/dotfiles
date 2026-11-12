-- Copy mode on prefix+[ : the pane's scrollback opens in nvim in a floating pane.
-- v / V select, enter copies to the clipboard and closes, q closes.
-- Stand-in until Rex ships a native copy mode; a full-screen program shows only
-- its visible rows, because the alternate screen keeps no scrollback.
-- nvim loads the normal config; the mappings are buffer-local so they win over
-- global mappings from plugins.

local floating_pane = require("floating_pane")

local SCROLLBACK_IN_NVIM = [[
rex capture -s "$1" -b "$2" --trim | nvim -R \
  -c 'xnoremap <buffer> <CR> "+y<Cmd>qa!<CR>' \
  -c 'xnoremap <buffer> q <Cmd>qa!<CR>' \
  -c 'nnoremap <buffer> q <Cmd>qa!<CR>' \
  -c 'normal! G' -
]]

rex.action{
  name  = "copy_mode",
  title = "Copy Mode (Scrollback in nvim)",
  run   = function(ctx, args)
    local layer = floating_pane.run(ctx, SCROLLBACK_IN_NVIM)
    return { block_ids = layer.block_ids }
  end,
}

rex.bind("ctrl+t>[", "copy_mode")
