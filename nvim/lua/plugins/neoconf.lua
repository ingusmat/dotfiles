return {
  "folke/neoconf.nvim",
  priority = 1000, -- must be very early
  config = function()
    require("neoconf").setup({})
  end,
}
