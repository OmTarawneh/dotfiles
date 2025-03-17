return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      --
      keymaps = {
        insert = "<C-g>s", -- Insert mode: Use Ctrl+g followed by 's'
        insert_line = "<C-g>S", -- Insert mode: Surround entire line
        normal = "gS", -- Normal mode: Surround
        normal_cur = "gSS", -- Normal mode: Surround current line
        normal_line = "gS_", -- Normal mode: Surround line
        normal_cur_line = "gSS_", -- Normal mode: Surround current line and linewise
        visual = "gS", -- Visual mode: Surround
        delete = "gSd", -- Normal mode: Delete surround
        change = "gSc", -- Normal mode: Change surround
      },
    })
  end,
}
