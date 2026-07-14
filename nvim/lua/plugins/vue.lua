return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {},
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = vim.fn.system("npm root -g"):gsub("\n", "") .. "/@vue/typescript-plugin",
                languages = { "vue" },
              },
            },
          },
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "vue-language-server", "prettier" },
    },
  },
}
