-- Key modes: sets of bindings that apply only while the mode is active.

-- repeat: stands in for tmux's `bind -r`, which Rex has no repeat timer for
rex.mode("repeat", { exclusive = true })
rex.bind("ctrl+t>ctrl+r", "client.mode.enter", { name = "repeat" })
rex.bind("repeat/enter", "client.mode.exit")
rex.bind("repeat/escape", "client.mode.exit")
rex.bind("repeat/e", "pane.close_others")

-- resize: arrow keys resize the focused pane
rex.mode("resize", { exclusive = true })
rex.bind("ctrl+t>shift+r", "client.mode.enter", { name = "resize" })
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/down", "pane.resize", { direction = "down" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/right", "pane.resize", { direction = "right" })
