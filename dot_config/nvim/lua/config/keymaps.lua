-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 沿用旧 NvChad 配置里的两个个人习惯
-- 注意：LazyVim 的 flash.nvim 会增强 f/F/t/T 与 ;/, 的重复跳转，
-- 若发现 ";" 行为冲突，删掉下面这一行即可
vim.keymap.set("n", ";", ":", { desc = "进入命令行模式（省一次 Shift）" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "插入模式退出" })

-- Ctrl-Z 二次确认，防止误触挂起
vim.keymap.set({ "n", "i", "v" }, "<C-z>", function()
  local choice = vim.fn.confirm("Suspend Neovim?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.cmd("suspend")
  end
end, { desc = "Suspend (confirm)" })
