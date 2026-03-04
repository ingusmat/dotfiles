return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.preselect = cmp.PreselectMode.None

    opts.completion = opts.completion or {}
    opts.completion.autocomplete = false -- <- no popup while typing

    -- Ensure we override AFTER any preset mappings
    opts.mapping = opts.mapping or {}
    opts.mapping["<Tab>"] = nil
    opts.mapping["<S-Tab>"] = nil

    opts.mapping["<C-Space>"] = cmp.mapping.complete()

    opts.mapping["jk"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = false })
      else
        fallback()
      end
    end, { "i", "s" })

    return opts
  end,
}

