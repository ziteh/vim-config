return {
  colorscheme = "onedark", -- Theme
  icons = {
    VimIcon = "",
    ScrollText = "",
    -- GitBranch = "",
    GitAdd = "",
    GitChange = "",
    GitDelete = "",
  },
  heirline = {
    separators = {
      left = { "", " " },
      right = { " ", "" },
      tab = { "", "" },
    },
    -- add new colors that can be used by heirline
    colors = function(hl)
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      -- use helper function to get highlight group properties
      local comment_fg = get_hlgroup("Comment").fg
      hl.git_branch_fg = comment_fg
      hl.git_added = comment_fg
      hl.git_changed = comment_fg
      hl.git_removed = comment_fg
      hl.blank_bg = get_hlgroup("Folded").fg
      hl.file_info_bg = get_hlgroup("Visual").bg
      hl.nav_icon_bg = get_hlgroup("String").fg
      hl.nav_fg = hl.nav_icon_bg
      hl.folder_icon_bg = get_hlgroup("Error").fg
      return hl
    end,
    attributes = {
      mode = { bold = true },
    },
    icon_highlights = {
      file_icon = {
        statusline = false,
      },
    },
  },
  polish = function()
    ----- Neovide GUI -----
    if vim.g.neovide then
      vim.o.guifont = "Fira Code,FiraCode Nerd Font:h11"
      vim.g.neovide_scale_factor = 1.0
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
  end,
}
