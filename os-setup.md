picgo: 安装s3插件，`picgo add s3`

yazi：安装插件，`ya pkg upgrade`

bitwarden：配置后端url：`bw config server https://xxxxx`

zimfw：安装插件：`zimfw install`

配置mise

配置Rime，下载万象模型，见 <https://www.mintimate.cc/zh/guide/languageModel.html>
<https://github.com/amzxyz/RIME-LMDG>

# common

thunderbird配置需要手动导出

# macos

raycast需要手动导出
snipaste需要反激活

# windows

## chezmoi 在 Windows 上会部署什么

只部署下面 4 组，其余配置（.zshrc/.p10k/.zimrc/.tmux/.ssh/.gitconfig/.ideavimrc/.custom-bin/.claude/.codex 等等）全部限定在 macOS/Linux，不会在 `%USERPROFILE%` 下生成：

- `.config/` → 整棵（mise、nvim、pip、uv、yazi、fastfetch……）
- `.m2/settings.xml`
- `.pi/agent/**`
- `AppData/Roaming/Rime/**` → 小狼毫用户目录 `%APPDATA%\Rime`

注意 `.config/karabiner/karabiner.json` 也会被一起铺到 Windows：`.chezmoiignore` 里 `!` 放行规则的优先级高于忽略规则，做不到「先放行整棵 `.config` 再挖掉 karabiner」。该文件在 Windows 上不会被任何程序读取（Karabiner 只有 macOS 能跑），属无害静态文件。

## 让 %APPDATA% 系工具改读 ~/.config

nvim / yazi / pip / uv 在 Windows 上默认只认 `%APPDATA%`（neovim 读 `~/AppData/Local/nvim`、yazi 读 `%AppData%\yazi\config`、pip 读 `%APPDATA%\pip\pip.ini`、uv 读 `%APPDATA%\uv\uv.toml`），所以必须设环境变量，否则上面铺出去的 `~/.config/**` 等于白铺。

在 PowerShell 7 的 profile（`$PROFILE`，一般是 `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`）里加：

```powershell
$env:XDG_CONFIG_HOME = "$HOME\.config"                    # nvim 依此读 ~/.config/nvim
$env:YAZI_CONFIG_HOME = "$HOME\.config\yazi"
$env:PIP_CONFIG_FILE  = "$HOME\.config\pip\pip.conf"
$env:UV_CONFIG_FILE   = "$HOME\.config\uv\uv.toml"
```

- `.config/mise` **不需要**设置，mise 在 Windows 上本来就按 `~/.config/mise/config.toml` 查找
- 设了 `XDG_CONFIG_HOME` 会连带影响其他 XDG-aware 工具（starship/bat/rg/fd/helix 等），它们会从 `%APPDATA%` 改读 `~/.config`，第一次设完建议过一遍
- 写在 profile 里只对「从终端启动的程序」生效，从资源管理器/GUI 启动的程序读不到
- `$PROFILE` 的真实路径可能被 OneDrive 文档备份挪到 `~\OneDrive\Documents\...`，先 `echo $PROFILE` 确认

## 首次 clone / apply 之前

1. `core.autocrlf`：仓库已加 `.gitattributes`（`* -text`）。如果这台 Windows 之前已经 clone 过，Git for Windows 默认的 `core.autocrlf=true` 可能已经把 .zshrc 等模板 checkout 成 CRLF（chezmoi 会原样铺出去，zsh 读到 ^M 直接报错）。最干净的做法是删掉 `%USERPROFILE%\.local\share\chezmoi` 重新 clone；或至少先 `git config core.autocrlf false` 再重新 checkout
2. 先把 `age.key` 拷到 `%USERPROFILE%\.config\chezmoi\age.key`，否则 `.picgo/config.json` 无法解密
3. `bw login` + `bw unlock`（见上面 bitwarden 一条），否则带密钥的模板会让 `chezmoi apply` 直接失败
4. `chezmoi init --apply LystranG/dotfiles`
5. 重开 PowerShell 确认 profile 里的几个 env 生效，再逐个验证 nvim/yazi/pip/uv 确实读到了 `~/.config` 下的配置

## Rime（小狼毫 Weasel）

- 用户目录是 `%APPDATA%\Rime`，chezmoi 会铺 default.custom.yaml、double_pinyin_flypy.custom.yaml、rime_mint.custom.yaml、wanxiang.yaml 四份
- 万象模型仍需手动下载，见上面「配置Rime」的链接
- 外观（字体/候选框/配色）对应 Weasel 的 `weasel.custom.yaml`，仓库里暂时没有（现有的 `squirrel.custom.yaml` 只对 macOS 的鼠须管生效），所以 Windows 上目前是默认外观
- `AppData/Roaming` 是按 `%APPDATA%` 默认位置写死的字面路径，若改过 Roaming 的存放位置需要同步调整源目录
