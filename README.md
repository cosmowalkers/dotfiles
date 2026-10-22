# dotfiles

用 [chezmoi](https://www.chezmoi.io/) 管理的个人配置文件。公开仓库，内容已脱敏（无密钥、无公司信息）。

## 管理内容

| 类别 | 文件 |
|------|------|
| nvim | `~/.config/nvim/**`（主题跟随 macOS 亮暗、avante AI 供应商等） |
| zsh | `~/.zshrc` / `~/.zshenv` / `~/.zlogin` / `~/.p10k.zsh` |
| vim / ideavim / nuxt | `~/.vimrc` / `~/.ideavimrc` / `~/.nuxtrc` |
| git | `~/.gitconfig`（模板）/ `~/.gitignore_global` |
| ghostty | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |
| VSCode / Cursor | settings / keybindings / snippets |

## 密钥说明

密钥**不入库**，集中在 `~/.secrets`（权限 600），由 `~/.zshrc` 末尾 source。清单（key = 用途）：

```text
GITHUB_TOKEN         = GitHub 个人访问令牌（gh CLI 认证 / git push / Release 发布附件）
OPENROUTER_API_KEY   = OpenRouter API 密钥（多模型聚合 API）
GITEE_TOKEN          = Gitee 私人令牌（Gitee Release 发布附件）
SUGON_API_KEY        = Sugon AI Gateway API Key（avante.nvim / codex sugon profile）
ANTHROPIC_AUTH_TOKEN = Anthropic 代理认证（可选，注释保留）
ANTHROPIC_BASE_URL   = Anthropic 代理地址（可选，注释保留）
```

## 日常使用

```bash
# 在编辑器 GUI 里改完配置后，同步回源仓库
chezmoi re-add ~/Library/Application\ Support/Code/User/settings.json   # 也可 re-add --all
cd ~/.local/share/chezmoi && git add -A && git commit -m "chore: ..." && git push

# 直接编辑源配置（保存后自动同步到本机）
chezmoi edit --apply ~/.zshrc

# 改本机生效文件（不入库，如密钥）
vim ~/.secrets && source ~/.secrets
```

> 注意：VSCode/Cursor 的 `settings.json` 会被插件写入 cookie/token 等运行时凭据。
> `re-add` 前后建议 `chezmoi diff` / grep 扫描敏感项，避免把凭据带进仓库。

## 新机恢复

```bash
brew install chezmoi
chezmoi init cosmowalkers   # 拉取 dotfiles
chezmoi apply               # 部署到新机
```

部署后需手动补两块**本机专属**配置（不入库）：

1. `~/.secrets` —— 按上文清单填密钥（chmod 600）
2. `~/.config/chezmoi/chezmoi.toml` —— 本机变量（公司相关值：AI 网关、公司 git 目录等）

另：`~/.company.zsh`、`~/.npmrc`、`~/.gitconfig-work` 也是本机专属（公司配置），chezmoi 不管理，换机时按需手动创建。

## 命名约定速查

chezmoi 源文件用前缀表达目标属性：

| 前缀/后缀 | 含义 |
|-----------|------|
| `dot_` | 目标文件名以 `.` 开头（如 `dot_zshrc` → `~/.zshrc`） |
| `private_` | 目标权限为本人专属（600/700） |
| `.tmpl` | 模板，apply 时先渲染（真实值放本机 `chezmoi.toml`） |
