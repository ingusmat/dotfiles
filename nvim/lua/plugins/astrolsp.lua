return {
  "AstroNvim/astrolsp",
  opts = {
    servers = { "ts_ls", "volar" },
    config = {
      ts_ls = {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      },
      vue_ls = {
        filetypes = { "vue" },
      },
    },
  },
}
