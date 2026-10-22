local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- ===== 按技术栈启用的 LazyVim extras =====
    -- Vue 3 主力栈：会自动带上 lang.typescript，并装 vue_ls(Volar) + vtsls + @vue/typescript-plugin
    { import = "lazyvim.plugins.extras.lang.vue" },
    -- React / React Native / Node：vtsls + ts/tsx treesitter + js-debug-adapter(DAP)
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- Python / Agent 开发：basedpyright + ruff + debugpy
    { import = "lazyvim.plugins.extras.lang.python" },
    -- Tailwind 类名补全与预览
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- JSON schema 支持（package.json / tsconfig.json 智能提示）
    { import = "lazyvim.plugins.extras.lang.json" },
    -- Markdown 写作（README / 文档生成）
    { import = "lazyvim.plugins.extras.lang.markdown" },
    -- ESLint 集成（前端必备）
    { import = "lazyvim.plugins.extras.linting.eslint" },
    -- Prettier：覆盖 js/jsx/ts/tsx/css/scss/less/html/json/md/yaml/vue 的格式化
    { import = "lazyvim.plugins.extras.formatting.prettier" },

    -- Snacks picker：替代 telescope/fzf，提供 project/files/grep 等查找功能
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
