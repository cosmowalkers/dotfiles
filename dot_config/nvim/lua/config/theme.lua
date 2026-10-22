-- 主题管理：跟随 macOS 系统外观切换亮/暗，并记住 <leader>uC 中每个外观的选择
local M = {}

local state_path = vim.fn.stdpath("state") .. "/theme.json"

-- 亮色用 dawnfox，暗色用 nightfox
local appearance_schemes = {
  light = "dawnfox",
  dark = "nightfox",
}

-- 当前 macOS 系统外观："dark" 或 "light"
-- 暗色模式下 defaults 会输出 "Dark"，亮色模式下该键不存在
function M.appearance()
  local ok, result = pcall(vim.fn.system, { "defaults", "read", "-g", "AppleInterfaceStyle" })
  if ok and vim.trim(result) == "Dark" then
    return "dark"
  end
  return "light"
end

function M.load()
  local ok, lines = pcall(vim.fn.readfile, state_path)
  if not ok or not lines or #lines == 0 then
    return {}
  end
  local ok2, data = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not ok2 or type(data) ~= "table" then
    return {}
  end
  return data
end

function M.save(data)
  pcall(vim.fn.writefile, { vim.json.encode(data) }, state_path)
end

-- 当前外观想用的主题：<leader>uC 选过的优先，否则用默认
function M.wanted(appearance)
  appearance = appearance or M.appearance()
  return M.load()[appearance] or appearance_schemes[appearance]
end

-- 按指定外观应用主题
function M.apply(appearance)
  local scheme = M.wanted(appearance)
  if scheme ~= vim.g.colors_name then
    vim.cmd.colorscheme(scheme)
  end
end

-- <leader>uC 选中后记录到当前系统外观
function M.pick(name)
  local data = M.load()
  data[M.appearance()] = name
  M.save(data)
  vim.cmd.colorscheme(name)
end

return M
