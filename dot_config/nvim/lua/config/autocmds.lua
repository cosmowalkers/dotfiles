-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- ============ 输入法：退出插入模式 → 切回英文 ============
local function switch_im_to_en()
  vim.fn.system("/opt/homebrew/bin/im-select com.apple.keylayout.ABC")
end

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("user_im_select", { clear = true }),
  callback = switch_im_to_en,
})
