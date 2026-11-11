-- lazygit in a floating pane on prefix+g, opened in the focused pane's directory.

local floating_pane = require("floating_pane")

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
    floating_pane.run(ctx, "lazygit", focused_pane_directory(ctx.block_id))
  end,
}

rex.bind("ctrl+t>g", "lazygit_popup")
