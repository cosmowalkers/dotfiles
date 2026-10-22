-- 备选主题，全部懒加载，只在执行 :colorscheme <name> 时才载入
local theme = require("config.theme")

return {
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },

  -- 亮/暗切换都要用，不能懒加载
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      -- 先按当前系统外观应用一次主题
      vim.cmd.colorscheme(theme.wanted())
    end,
  },

  -- 跟随 macOS 系统外观自动切换亮/暗（3 秒轮询，启动时立即同步）
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        theme.apply("dark")
      end,
      set_light_mode = function()
        theme.apply("light")
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- 启动时按系统外观取主题，<leader>uC 选过的优先
      colorscheme = function()
        vim.cmd.colorscheme(theme.wanted())
      end,
    },
  },
}
