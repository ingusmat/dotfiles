local ok, builtin = pcall(require, "telescope.builtin")
if ok then
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = true, desc = "LSP definitions (pick)" })
  vim.keymap.set("n", "gI", builtin.lsp_implementations, { buffer = true, desc = "LSP implementations (pick)" })
  vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = true, desc = "LSP references (pick)" })
else
  -- fallback if telescope isn't available for some reason
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true, desc = "LSP definition" })
end

-- stop K from punting to man/help when hover is empty
vim.opt_local.keywordprg = ""
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true, desc = "LSP hover" })

-- make your <leader>gf do something useful (LSP), not Vim's gf
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.definition, { buffer = true, desc = "Go to definition (LSP)" })
