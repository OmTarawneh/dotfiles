return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        typescript = {
          maxTsServerMemory = 8048,
        },
      },
      denols = {
        init_options = {
          lint = true,
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true

          vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<leader>df",
            "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
            { noremap = true, silent = true }
          )

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      },
    },
  },
}
