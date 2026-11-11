-- Rex configuration, migrated from tmux and Herdr (prefix ctrl+t).

rex.bind("ctrl+t>ctrl+t", "pane.send_key", { key = "ctrl+t" })

-- tmux
rex.bind("ctrl+t>e", "pane.close_others")

rex.mode("repeat", { exclusive = true })
rex.bind("ctrl+t>ctrl+r", "client.mode.enter", { name = "repeat" })
rex.bind("repeat/enter", "client.mode.exit")
rex.bind("repeat/escape", "client.mode.exit")
rex.bind("repeat/e", "pane.close_others")

-- Herdr
rex.bind("ctrl+t>r", "client.config.reload")

rex.mode("resize", { exclusive = true })
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("ctrl+t>shift+r", "client.mode.enter", { name = "resize" })
rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/down", "pane.resize", { direction = "down" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/right", "pane.resize", { direction = "right" })

rex.bind("ctrl+t>,", "client.tab.rename")
rex.bind("ctrl+t>shift+7", "client.tab.close")
rex.bind("ctrl+shift+left", "client.tab.move", { direction = "backward" })
rex.bind("ctrl+shift+right", "client.tab.move", { direction = "forward" })

rex.bind("ctrl+t>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+shift+h", "pane.focus", { direction = "left" })
rex.bind("ctrl+t>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+shift+j", "pane.focus", { direction = "down" })
rex.bind("ctrl+t>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+shift+k", "pane.focus", { direction = "up" })
rex.bind("ctrl+t>l", "pane.focus", { direction = "right" })
rex.bind("ctrl+shift+l", "pane.focus", { direction = "right" })

rex.bind("ctrl+shift+[", "session.previous")
rex.bind("ctrl+shift+]", "session.next")

rex.bind("ctrl+t>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+t>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+t>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+t>-", "pane.split", { direction = "down" })
rex.bind("ctrl+t>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+t>shift+-", "pane.split", { direction = "down" })

rex.bind("ctrl+t>u", "session.switch")

-- New session (workspace) on prefix+shift+n
rex.bind("ctrl+t>shift+n", "session.new")

-- Next / previous tab on prefix+n / prefix+p
rex.bind("ctrl+t>n", "client.tab.next")
rex.bind("ctrl+t>p", "client.tab.previous")

-- lazygit in a floating pane on prefix+g, opened in the focused pane's directory
local function focused_pane_directory(block_id)
  local process = rex.block.call("com.superlogical.terminal", "process", { block_id = block_id })
  if process == nil then return nil end
  local running = process.foreground or process.child
  return running and running.cwd
end

rex.action{
  name  = "lazygit_popup",
  title = "Open lazygit in a Floating Pane",
  run   = function(ctx, args)
    local _, err = rex.session.new_layer{
      bounds = { 0.05, 0.05, 0.9, 0.9 },
      focus  = true,
      layout = rex.layout.block{
        flavor  = "com.superlogical.terminal.shell",
        options = { command = { "lazygit" }, cwd = focused_pane_directory(ctx.block_id) },
      },
    }
    if err ~= nil then error(err, 0) end
  end,
}

rex.bind("ctrl+t>g", "lazygit_popup")

-- New tab on prefix+c
rex.bind("ctrl+t>c", "client.tab.new")
