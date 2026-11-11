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
