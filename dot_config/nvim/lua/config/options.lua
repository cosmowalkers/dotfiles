-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Add local luarocks packages to Lua path (avante.nvim dependency: mega.cmdparse)
local lr_home = os.getenv("HOME") .. "/.luarocks/share/lua/5.5"
package.path = package.path .. ";" .. lr_home .. "/?.lua;" .. lr_home .. "/?/init.lua"

-- spell 引擎跳过 CJK 字符，保留英文拼写检查；camel 自动拆分 camelCase 单词
vim.opt.spelllang = { "en_us", "cjk" }
vim.opt.spelloptions = "camel"
