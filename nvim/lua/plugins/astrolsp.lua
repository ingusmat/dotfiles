return {
  "AstroNvim/astrolsp",
  opts = {
    servers = { "ts_ls", "volar" },
    config = {
      ts_ls = {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      },
      volar = {
        init_options = {
          typescript = { tsdk = "node_modules/typescript/lib" },
        },
      },
    },
  },
}
