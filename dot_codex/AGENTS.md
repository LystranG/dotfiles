以简体中文的方式回复用户。使用MultiAgent时请不要随意打断子代理的任务，请使用较长的wait时间或者直接等待直到子代理有输出。

积极使用网络搜索功能和Context7 MCP搜索最新的文档。

@RTK.md (该文件在用户目录.codex目录下，不在项目中)
合理利用系统提供的以下命令行工具(同时严格遵循 RTK.md 的内容)：

- rg: (ripgrep)
- ag: (The Silver Searcher)
- fd: (fdfind)
- fzf
- jq
- pandoc

## MultiAgent

- 只在子任务彼此独立、不会互相写冲突时使用 MultiAgent。
- `wait` 默认使用长超时：`timeout_ms=1000000`；不要依赖默认 30 秒。
- `timeout_ms` 是最长等待时间，不是固定等待时长；子 agent 提前完成时，`wait` 应立即返回。
- `wait` 超时只表示“暂未完成”，不表示失败、卡死或应被打断。
- 对多个 agent 调用 `wait(ids=[...])` 时，一次返回只表示其中某个 agent 已到最终状态，不表示全部完成。
- 默认不要打断子 agent；补充信息时使用 `send_input(..., interrupt=false)`。
- 只有在用户明确要求、任务明显跑偏、发生冲突或存在安全风险时，才允许 `interrupt=true`。
- 用户要求不要打断子代理时，优先长时间 `wait`，不要频繁短轮询。
