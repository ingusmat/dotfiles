---@type LazySpec
return {
  "wtfox/claude-chat.nvim",
  config = true,
  opts = {
    -- Optional configuration
    split = "vsplit", -- "vsplit", "split", or "float"
    position = "right", -- "right", "left", "top", "bottom" (ignored for float)
    width = 0.6, -- percentage of screen width (for vsplit or float)
    height = 0.8, -- percentage of screen height (for split or float)
    claude_cmd = "claude", -- command to invoke Claude Code
    float_opts = { -- options for floating window
      relative = "editor",
      border = "rounded",
      title = " Claude Chat ",
      title_pos = "center",
    },
    -- keymaps = {  -- customize if needed
    --   global = "<leader>cc",
    --   terminal = {
    --     close = "<C-q>",
    --     toggle = "<C-.>",
    --   },
    -- },
  },
}
