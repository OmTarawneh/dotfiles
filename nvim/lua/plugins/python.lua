return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
              },
              python = {
                pythonPath = function()
                  -- Try to find Python from pyenv first
                  local pyenv_root = os.getenv("PYENV_ROOT") or os.getenv("HOME") .. "/.pyenv"
                  local pyenv_version = os.getenv("PYENV_VERSION")

                  if pyenv_version then
                    return pyenv_root .. "/versions/" .. pyenv_version .. "/bin/python"
                  end

                  -- Fallback to system python
                  return "python3"
                end,
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Enable format on save for Python files
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false })
                end,
              })
            end
          end,
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
          on_attach = function(client, bufnr)
            -- Disable formatting in favor of conform.nvim
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },

  -- Ruff for ultra-fast linting and formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
      },
      formatters = {
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
        ruff_organize_imports = {
          command = "ruff",
          args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
  },

  -- Virtual Environment Selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
        "project-test-py3.13", -- Add your specific venv name
      },
      auto_refresh = true,
      search_venv_managers = true,
      search_workspace = true,
      search = {
        ".",
        "..",
        "../..",
        "../../..",
        "~/.virtualenvs",
        "~/.pyenv/versions",
        "~/.conda/envs",
        "~/anaconda3/envs",
        "~/miniconda3/envs",
        "~/.local/share/virtualenvs", -- Poetry default location
      },
      dap_enabled = true,
      parents = 4,
      notify_user_on_activate = true,
      settings = {
        search_my = true, -- Search in ~/.local/share/virtualenvs
        search_venv_managers = true,
        search_workspace = true,
        search_my_workspace = true,
      },
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)

      -- Auto-detect and activate virtual environment on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Check if we're in a Python project with a .venv
          local cwd = vim.fn.getcwd()
          local venv_path = cwd .. "/.venv"

          if vim.fn.isdirectory(venv_path) == 1 then
            -- Set the virtual environment for this session
            vim.env.VIRTUAL_ENV = venv_path
            vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
            print("Virtual environment detected: " .. venv_path)
          end
        end,
      })
    end,
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select Virtual Environment" },
      { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select Cached Virtual Environment" },
      { "<leader>cR", "<cmd>VenvSelectRefresh<cr>", desc = "Refresh Virtual Environments" },
    },
  },

  -- Python Debugging
  -- {
  --     "mfussenegger/nvim-dap-python",
  --     dependencies = "mfussenegger/nvim-dap",
  --     ft = "python",
  --     config = function()
  --         -- Use the correct Mason API to get debugpy path
  --         local debugpy_path = nil
  --         local ok, registry = pcall(require, "mason-registry")
  --         if ok then
  --             local debugpy = registry.get_package("debugpy")
  --             if debugpy and debugpy:is_installed() then
  --                 debugpy_path = debugpy:get_install_path() .. "/venv/bin/python"
  --             end
  --         end
  --
  --         -- Fallback to system debugpy if Mason version not found
  --         if not debugpy_path then
  --             debugpy_path = "python"
  --         end
  --
  --         require("dap-python").setup(debugpy_path)
  --
  --         -- Debug configurations
  --         require("dap-python").test_runner = "pytest"
  --
  --         -- Keybindings for debugging
  --         vim.keymap.set("n", "<leader>dPt", function()
  --             require("dap-python").test_method()
  --         end, { desc = "Debug Test Method" })
  --
  --         vim.keymap.set("n", "<leader>dPc", function()
  --             require("dap-python").test_class()
  --         end, { desc = "Debug Test Class" })
  --
  --         vim.keymap.set("v", "<leader>dPs", function()
  --             require("dap-python").debug_selection()
  --         end, { desc = "Debug Selection" })
  --     end,
  -- },

  -- Python-specific keymaps
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     keys = {
  --       { "<leader>cr", "<cmd>LspRestart<cr>", desc = "Restart LSP" },
  --       {
  --         "<leader>cP",
  --         function()
  --           local file = vim.fn.expand("%:p")
  --           vim.cmd("!python " .. file)
  --         end,
  --         desc = "Run Current Python File",
  --       },
  --       {
  --         "<leader>ct",
  --         function()
  --           local file = vim.fn.expand("%:p")
  --           vim.cmd("!python -m pytest " .. file .. " -v")
  --         end,
  --         desc = "Run Pytest for Current File",
  --       },
  --       {
  --         "<leader>cT",
  --         function()
  --           vim.cmd("!python -m pytest . -v")
  --         end,
  --         desc = "Run All Tests",
  --       },
  --     },
  --   },
  -- },

  -- Additional Python tools
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "toml",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- Mason tools for Python
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "ruff",
        "debugpy",
        "black",
        "isort",
        "flake8",
        "mypy",
        "pylint",
      },
    },
  },
}
