## Global Instructions

- 启动子代理请设置一个极长的timeout时间，不要让子代理的任务被 timeout 打断
- 子代理是有明确边界的执行单元，不是把模糊问题丢出去的替身，问题需要相当具体和详细，也不要丢失太多信息
- 子代理执行任务时主代理不要擅自收尾，必需等待所有的子代理执行完毕再做最后的收尾工作，不要认为信息已经足够了而提前结束任务
- 最终给用户的回复请使用简体中文，除非用户明确要求使用其他语言
- 代码需要有明确的说明或注释，特别是对函数/方法、变量、文件都需要进行注释的说明
- 如果有一些命令是需要频繁执行的，可以使用justfile来管理的，可以询问用户是否可以是用使用just来管理这些命令
- 如果需要新建skill，禁止使用global skill，配置为local skill，除非用户明确要求使用global skill；记忆也是同理的
- 代码编写工作中，必需用户明确授权让你开始执行代码实现你再开始实现，禁止擅自开始实现，一般来说都是先进行设计再与用户进行确认然后再开始实现。


## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.

## Agent 工具选择策略

### 代码探索优先级(只对代码工作生效，如果对应工具不可用则忽略，不要强行使用不可用的工具)

源码关系问题先 CodeGraph；
结构模式问题用 ast-grep；
精确文本问题才用 rg；
CodeGraph 无结果或索引过期时再 fallback。

1. **Serena（符号级）**：找定义、引用、实现、类型关系；按 symbol 读取/编辑/替换等等操作；安全 rename/refactor。优先用于“某函数/类/接口在哪里、谁调用它”。
2. **CodeGraph（全局图）**：跨模块调用链、依赖图、影响范围、相关测试、架构/复杂度分析。修改公共接口、跨模块重构前先查影响范围。
3. **ast-grep（结构级）**：按 AST 查函数调用、import、异常处理、危险 API；批量结构化改写前先只读预览命中。
4. **`rg`（文本级）**：错误文本、配置键、环境变量、URL、注释、文档和精确字面量。
5. **`fd`（文件级）**：按名称/扩展名查文件；不要用无边界 `find .`。

- 已有 Serena / CodeGraph 能回答的问题，不要先用大量 `rg` + `read` 重建上下文。
- 所有搜索必须限定相关目录与语言/文件类型。
- 默认禁止访问：`node_modules/`、`dist/`、`build/`、`coverage/`、`.next/`、`.cache/`、`vendor/`、日志、二进制、生成文件、`*.min.js`、`*.map`、大型 lockfile 等等与代码理解无关的目录和文件。

### Shell 与输出预算

- `rg`：小范围精确文本搜索；必须指定目录，禁止 `rg "..." .`。
- `fd`：查文件；必须指定起始目录，禁止无边界列举仓库。
- `grep` / `find`：仅当 `rg` / `fd` 不适用或不可用时使用。
- `jq` / `yq`：解析或修改 JSON/YAML；不要用 grep/sed 解析结构化数据。

RTK：

- 普通、输出很短的命令：直接执行原命令。
- 预期输出较长的搜索、目录列表、git diff/log、测试、lint、构建、容器日志：显式使用对应 `rtk` 命令，优先 `rtk grep`、`rtk find`、`rtk read`、`rtk git diff`、`rtk test <command>`、`rtk summary <command>`
- RTK 只压缩输出，不是扩大搜索范围的理由；先缩小范围，再使用 RTK
- 需要完整失败信息时，根据 RTK 提示使用 `rtk recall <id>`，不要无故重跑大命令
- mvn 命令优先使用提供的mvn工具，这是专门为mvn压缩设计的工具，可以不使用rtk

### 项目命令与验证

- 若存在 `justfile`，开始时先运行 `just --list`；项目安装、测试、lint、构建和检查优先使用 `just <recipe>`
- 修改 Dockerfile：运行 `hadolint Dockerfile` 或 `just docker-lint`
- 修改 Shell 脚本：运行 `shellcheck <file>` 或 `just shell-lint`
- 修改格式化受管文件：运行项目 formatter（例如 `prettier --check`）或 `just format-check`
- 完成中等以上改动或准备提交：运行 `pre-commit run --all-files` 或 `just preflight`
- 未实际运行检查时，不得声称验证通过

### 其他

- `gh`：查询 GitHub issue、PR、CI、release；创建/评论/合并/发布等写操作须先征得用户确认

