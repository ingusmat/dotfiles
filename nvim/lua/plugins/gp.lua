return {
  "Robitx/gp.nvim",
  config = function()
    require("gp").setup({
      default_chat_agent = "GPT-5.2",
      agents = {
        {
          provider = "openai",
          name = "GPT-5.2",
          chat = true,
          command = false,
          model = { model = "gpt-5.2" },
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
      },
    })

    vim.keymap.set("n", "<leader>aa", ":GpChatNew vsplit<CR>", { desc = "Ask GPT (chat)" })
  end,
}
