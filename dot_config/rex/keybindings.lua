-- Key bindings on the ctrl+t prefix, carried over from tmux and Herdr.

rex.bind("ctrl+t>ctrl+t", "pane.send_key", { key = "ctrl+t" })
rex.bind("ctrl+t>r", "client.config.reload")

-- Sessions
rex.bind("ctrl+t>shift+n", "session.new")
rex.bind("ctrl+t>u", "session.switch")
rex.bind("ctrl+shift+[", "session.previous")
rex.bind("ctrl+shift+]", "session.next")

-- Tabs
rex.bind("ctrl+t>c", "client.tab.new")
rex.bind("ctrl+t>n", "client.tab.next")
rex.bind("ctrl+t>p", "client.tab.previous")
rex.bind("ctrl+t>,", "client.tab.rename")
rex.bind("ctrl+t>shift+7", "client.tab.close")
rex.bind("ctrl+shift+left", "client.tab.move", { direction = "backward" })
rex.bind("ctrl+shift+right", "client.tab.move", { direction = "forward" })

-- Pane focus
rex.bind("ctrl+t>h", "pane.focus", { direction = "left" })
rex.bind("ctrl+shift+h", "pane.focus", { direction = "left" })
rex.bind("ctrl+t>j", "pane.focus", { direction = "down" })
rex.bind("ctrl+shift+j", "pane.focus", { direction = "down" })
rex.bind("ctrl+t>k", "pane.focus", { direction = "up" })
rex.bind("ctrl+shift+k", "pane.focus", { direction = "up" })
rex.bind("ctrl+t>l", "pane.focus", { direction = "right" })
rex.bind("ctrl+shift+l", "pane.focus", { direction = "right" })

-- Splits
rex.bind("ctrl+t>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+t>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+t>\\", "pane.split", { direction = "right" })
rex.bind("ctrl+t>-", "pane.split", { direction = "down" })
rex.bind("ctrl+t>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+t>shift+-", "pane.split", { direction = "down" })

rex.bind("ctrl+t>e", "pane.close_others")
