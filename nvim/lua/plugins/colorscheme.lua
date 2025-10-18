return {
  -- Use the built-in habamax colorscheme
  -- {
  --   lazy = false,
  --   priority = 1000,

  --   config = function()
  --     vim.cmd("colorscheme retrobox")
  --   end,
  -- },

  -- Other themes (commented out for now)
  -- {
  --   "projekt0n/github-nvim-theme",
  --   name = "github-theme",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("github-theme").setup({
  --       -- ...
  --     })
  --     vim.cmd("colorscheme github_dark")
  --   end,
  -- },

  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "dark"
  --     vim.cmd("colorscheme kanagawa")
  --   end,
  -- },

  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nordfox")
    end,
  },
}
