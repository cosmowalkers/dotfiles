-- React / JS / HTML / CSS 支持补充
-- LazyVim 没有 lang.html / lang.css 这类 extra，所以在这里手动挂 LSP。
-- React/TS/JS 本身已由 lang.typescript 的 vtsls 覆盖，不需要额外配置。
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
      },
    },
  },
}
