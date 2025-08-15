-- Set the Python host program to use the dedicated Neovim virtual environment
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/venv/bin/python')

-- Disable providers you don't need
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Set leader key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editor settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.tabstop = 4           -- Tab width
vim.opt.shiftwidth = 4        -- Indent width
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Smart indentation
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.cursorline = true     -- Highlight current line
vim.opt.termguicolors = true  -- Enable 24-bit colors
vim.opt.signcolumn = "yes"    -- Always show sign column

-- Search settings
vim.opt.ignorecase = true     -- Ignore case in search
vim.opt.smartcase = true      -- Case sensitive if uppercase used

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin configuration
require("lazy").setup({
  -- Catppuccin color scheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true, -- This gives the "blurred glass" effect
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "vim", "vimdoc", "markdown" },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black", "isort" },
          lua = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        direction = "horizontal",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },
})

-- Key mappings
local keymap = vim.keymap.set

-- Terminal toggle (Ctrl+\)
keymap("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
keymap("t", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Format code
keymap("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Save file
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Quit
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
