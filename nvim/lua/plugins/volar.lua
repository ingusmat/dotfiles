return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      volar = {
        init_options = {
          typescript = {
            tsdk = "node_modules/typescript/lib",
          },
        },
      },
    },
  },
}

