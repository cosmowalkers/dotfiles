return {
  "okuuva/auto-save.nvim",
  version = false,
  -- 只在离开文件时加载，不用 InsertLeave / TextChanged 触发了
  event = { "BufLeave", "FocusLost" },
  opts = {
    condition = function(buf)
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
      if ft == "snacks_dashboard" then
        return false
      end
      return true
    end,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" },
      defer_save = {}, -- 关掉编辑过程中的自动保存
      cancel_deferred_save = {},
    },
  },
}
