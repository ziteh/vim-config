----- Vim -----
vim.cmd("set nu rnu")
vim.cmd("set cursorline")

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set autoindent")
vim.cmd("set smartindent")

vim.cmd("set wrap")
vim.cmd("set linebreak")

vim.cmd("set ignorecase")
vim.cmd("set smartcase")

vim.cmd("set foldmethod=syntax")
vim.cmd("set nofoldenable")

vim.cmd("set encoding=utf8")
vim.cmd("set nocompatible") -- vim-polyglot
vim.cmd("syntax on")

----- Lazy.nvim -----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",       -- latest stable release
      lazypath
    }
  )
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {   -- Main theme
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({ style = "warm" })
      vim.cmd.colorscheme "onedark"
    end,
  },
  { "AlexvZyl/nordic.nvim" },
  { "EdenEast/nightfox.nvim" },   -- nordfox
  { "sheerun/vim-polyglot" },     -- Syntax
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          globalstatus = false,
        },
        sections = {
          lualine_a = { "branch" },
          lualine_b = { "filename" },
          lualine_c = { "diff", "diagnostics" },
          lualine_x = { "mode" },
          lualine_y = { "encoding", "filetype" },
          lualine_z = { "location", "progress" },
        },
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      label = { uppercase = false, },
      search = { multi_window = true, },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
}

require("lazy").setup(plugins)

----- Neovide GUI -----
if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.8
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_confirm_quit = true

  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0

  -- IME auto switch
  vim.g.neovide_input_ime = false
  local function set_ime(args)
    if args.event:match("Enter$") then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
  })
end
