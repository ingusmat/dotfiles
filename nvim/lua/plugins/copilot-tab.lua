return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true

    -- Accept Copilot suggestion safely (NO expr mapping)
    vim.keymap.set("i", "<S-Tab>", function()
      local keys = vim.fn["copilot#Accept"]("")
      vim.api.nvim_feedkeys(keys, "i", true)
    end, { silent = true })
  end,
}
