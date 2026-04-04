th = th or {}
th.git = th.git or {}
-- A. 自定义图标 (推荐使用 Nerd Fonts)
th.git.added_sign = "" -- 新增 (+)
th.git.deleted_sign = "" -- 删除 (-)
th.git.modified_sign = "" -- 修改 (笔)
th.git.renamed_sign = "" -- 重命名 (箭头)
th.git.untracked_sign = "" -- 未追踪 (?)
th.git.ignored_sign = "" -- 忽略 (眼睛)
-- B. 自定义图标颜色
th.git.added = ui.Style():fg("green")
th.git.deleted = ui.Style():fg("red")
th.git.modified = ui.Style():fg("blue")
th.git.renamed = ui.Style():fg("yellow")
th.git.untracked = ui.Style():fg("gray")
th.git.ignored = ui.Style():fg("darkgray")
require("git"):setup()

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("recycle-bin"):setup()

require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode = "dir" },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "parent",
	custom_desc_input = false,
	show_keys = false,
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})

Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

-- 显示 user/gourp
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 500, Status.RIGHT)
