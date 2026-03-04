return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Don’t let cmp auto-select candidates (reduces “overshoot”)
    opts.preselect = cmp.PreselectMode.None
    opts.completion = opts.completion or {}
    -- Optional: make menu only show when you ask (recommended)
    opts.completion.autocomplete = false

    -- Key part: remove Tab/S-Tab from cmp mappings
    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<Tab>"] = nil,
      ["<S-Tab>"] = nil,

      -- Keep completion usable intentionally:
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Esc>"] = cmp.mapping.abort(),

      -- Make Enter only confirm when menu is visible
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_selected_entry() then
          cmp.confirm({ select = false })
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    return opts
  end,
}
