--------------------------------------------------------------------------
-- Rex configuration, ported from ~/.tmux.conf
--
-- The tmux prefix (C-a) becomes the start of a key sequence: ctrl+a>c etc.
-- Check with `rex config check`, reload with ctrl+a>r or `rex config reload`.
--------------------------------------------------------------------------

local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"
local PREFIX = "ctrl+a>"

local function prefix(key, action, args)
  rex.bind(PREFIX .. key, action, args)
end

--------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------

-- The foreground process of a terminal, e.g. { name = "nvim", cwd = "..." }
local function foreground(block_id)
  local process = rex.block.call(TERMINAL, "process", { block_id = block_id })
  if process == nil then return nil end

  return process.foreground or (process.ancestors and process.ancestors[1])
end

-- Read from the process table rather than OSC 7, so it works without shell integration
local function cwd_of(block_id)
  local process = foreground(block_id)

  return (process and process.cwd) or os.getenv("HOME")
end

local function shell(cwd, command)
  local options = { cwd = cwd }

  -- Run through an interactive zsh so PATH, EDITOR, etc. from ~/.zshrc apply
  if command ~= nil then
    options.command = { "/bin/zsh", "-ic", command }
  end

  return rex.layout.block{ flavor = SHELL, options = options }
end

local function check(result, err)
  if err ~= nil then error(err, 0) end

  return result
end

local function leaves(node, found)
  found = found or {}

  if node.block_id ~= nil then
    found[#found + 1] = node.block_id
  elseif node.split ~= nil then
    leaves(node.split.before, found)
    leaves(node.split.after, found)
  end

  return found
end

local function all_horizontal(node)
  if node.split == nil then return true end

  return node.split.direction == "horizontal"
    and all_horizontal(node.split.before)
    and all_horizontal(node.split.after)
end

--------------------------------------------------------------------------
-- Actions
--------------------------------------------------------------------------

rex.action{
  name  = "new_tab_here",
  title = "New Tab in Current Directory",
  run   = function(ctx)
    check(rex.session.new_window{ layout = shell(cwd_of(ctx.block_id)) })
  end,
}

rex.action{
  name  = "split_here",
  title = "Split Pane in Current Directory",
  args  = { direction = "string", command = "string?", cwd = "string?" },
  run   = function(ctx, args)
    check(rex.session.new_split{
      anchor_block_id = ctx.block_id,
      direction = args.direction == "down" and "vertical" or "horizontal",
      side = "after",
      layout = shell(args.cwd or cwd_of(ctx.block_id), args.command),
      focus = true,
    })
  end,
}

-- tmux: display-popup
rex.action{
  name  = "popup",
  title = "Open Floating Terminal",
  args  = { command = "string", width = "number?", height = "number?" },
  run   = function(ctx, args)
    local width, height = args.width or 0.9, args.height or 0.9

    check(rex.session.new_layer{
      bounds = { (1 - width) / 2, (1 - height) / 2, width, height },
      layout = shell(cwd_of(ctx.block_id), args.command),
      focus = true,
    })
  end,
}

-- tmux: C (three panes at 25% / 50% / 25%, focus on the first)
rex.action{
  name  = "dev_layout",
  title = "New Tab with Dev Layout",
  run   = function(ctx)
    local cwd = cwd_of(ctx.block_id)
    local window = check(rex.session.new_window{
      layout = rex.layout.horizontal(0.25,
        shell(cwd),
        rex.layout.horizontal(2 / 3, shell(cwd), shell(cwd))),
    })

    check(rex.session.focus_block{ block_id = window.block_ids[1] })
  end,
}

-- tmux: M (resize exactly three side-by-side panes to 25% / 50% / 25%)
rex.action{
  name  = "rebalance_layout",
  title = "Rebalance Panes 25/50/25",
  run   = function(ctx)
    local view = check(rex.session.view{})
    local tiled

    for _, window in ipairs(view.windows or {}) do
      if window.window_id == view.active_window_id then
        for _, layer in ipairs(window.layers or {}) do
          if layer.kind == "tiled" then tiled = layer.layout end
        end
      end
    end

    if tiled == nil or #leaves(tiled) ~= 3 or not all_horizontal(tiled) then
      error("Layout resize requires exactly 3 side-by-side panes", 0)
    end

    local weights = { 1, 2, 1 }

    local function resize(node, offset)
      if node.split == nil then return end

      local before, after = leaves(node.split.before), leaves(node.split.after)
      local before_weight, after_weight = 0, 0

      for i = 1, #before do before_weight = before_weight + weights[offset + i] end
      for i = 1, #after do after_weight = after_weight + weights[offset + #before + i] end

      check(rex.session.resize_pane{
        direction = "horizontal",
        before_block_id = before[#before],
        after_block_id = after[1],
        ratio = before_weight / (before_weight + after_weight),
      })

      resize(node.split.before, offset)
      resize(node.split.after, offset + #before)
    end

    resize(tiled, 0)
    check(rex.session.focus_block{ block_id = leaves(tiled)[1] })
  end,
}

-- tmux: C-b (`tat`), switch to a session named after the current directory
rex.action{
  name  = "project_session",
  title = "Go to Project Session",
  run   = function(ctx)
    local cwd = cwd_of(ctx.block_id)
    local name = cwd:match("([^/]+)/*$"):gsub("%.", "-")
    local session_id

    for _, session in ipairs(check(rex.call("session.list")).sessions or {}) do
      if session.label == name then session_id = session.session_id end
    end

    if session_id == nil then
      session_id = check(rex.call("session.create", {
        label = name,
        initial_windows = { { layout = shell(cwd) } },
      })).session_id
    end

    rex.client.queue("session.select", { session_id = session_id })
  end,
}

--------------------------------------------------------------------------
-- Key bindings
--------------------------------------------------------------------------

prefix("ctrl+a", "pane.send_key", { key = "ctrl+a" })
prefix("r", "client.config.reload")

-- Windows (tabs)
prefix("c", "new_tab_here")
prefix("shift+c", "dev_layout")
prefix("n", "client.tab.next")
prefix("p", "client.tab.previous")
prefix(",", "client.tab.rename")
prefix("shift+7", "client.tab.close")

-- Panes
prefix("-", "split_here", { direction = "down" })
prefix("\\", "split_here", { direction = "right" })
prefix("b", "pane.move_to_new_tab")
prefix("j", "pane.move_to_tab")
prefix("z", "pane.zoom")
prefix("x", "pane.close")
prefix("o", "pane.focus_next")
prefix("=", "pane.balance")

-- tmux: s (swap-pane). Move the pane once with h/j/k/l or the arrows.
prefix("s", "client.mode.enter", { name = "move", once = true })
rex.mode("move", { exclusive = true })
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind("move/" .. key, "pane.move", { direction = direction })
  rex.bind("move/" .. direction, "pane.move", { direction = direction })
end

-- Pane resize
for _, direction in ipairs({ "left", "right", "up", "down" }) do
  rex.bind("shift+" .. direction, "pane.resize", { direction = direction })
end

-- Sessions
prefix("ctrl+b", "project_session")
prefix("ctrl+j", "session.switch")
prefix("shift+1", "session.close")
prefix("shift+x", "session.close")
prefix("shift+4", "session.rename")

-- Layouts
prefix("shift+m", "rebalance_layout")

-- Quick-launch
prefix("ctrl+k", "popup", { command = os.getenv("HOME") .. "/bin/rex-window-picker", width = 1.4, height = 0.4 })
prefix("w", "popup", { command = os.getenv("HOME") .. "/bin/rex-window-picker", width = 0.4, height = 0.4 })
prefix("h", "split_here", { direction = "right", command = "btop" })
prefix("t", "split_here", { direction = "right", command = "nvim todo.md", cwd = os.getenv("HOME") })
prefix("g", "split_here", { direction = "right", command = "lazygit" })
prefix("shift+g", "split_here", { direction = "right", command = "gh dash" })

--------------------------------------------------------------------------
-- Seamless navigation with nvim (replaces vim-tmux-navigator)
--
-- When nvim (or fzf) is in the foreground the key is passed through, and
-- nvim hands focus back to Rex with `rex focus` at the edge of its splits.
--------------------------------------------------------------------------

local PASSTHROUGH = { nvim = true, vim = true, view = true, fzf = true }

local function navigate(direction)
  return function(ctx)
    local process = foreground(ctx.block_id)

    if process ~= nil and PASSTHROUGH[process.name] then return false end

    rex.session.focus_direction{ direction = direction }

    return true
  end
end

rex.bind("ctrl+h", navigate("left"))
rex.bind("ctrl+j", navigate("down"))
rex.bind("ctrl+k", navigate("up"))
rex.bind("ctrl+l", navigate("right"))
