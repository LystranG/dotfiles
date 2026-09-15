## Global Instructions

- 启动子代理请设置一个极长的timeout时间，不要让子代理的任务被 timeout 打断
- 子代理是有明确边界的执行单元，不是把模糊问题丢出去的替身，问题需要相当具体和详细，也不要丢失太多信息
- 子代理执行任务时主代理不要擅自收尾，必需等待所有的子代理执行完毕再做最后的收尾工作，不要认为信息已经足够了而提前结束任务
- 最终给用户的回复请使用简体中文，除非用户明确要求使用其他语言

- 代码需要有明确的说明或注释，特别是对函数/方法、变量、文件都需要进行注释的说明


## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at the repo root), reach for it BEFORE grep/find or reading files when you need to understand or locate code:

- **MCP tool** (when available): `codegraph_explore` answers most code questions in one call — the relevant symbols' verbatim source plus the call paths between them, including dynamic-dispatch hops grep can't follow. Name a file or symbol in the query to read its current line-numbered source. If it's listed but deferred, load it by name via tool search.
- **Shell** (always works): `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is the user's decision.
