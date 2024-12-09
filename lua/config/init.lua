local M = {}

M.icons = {
	kinds = {
		Array = "󰅪 ",
		Boolean = " ",
		Class = "󰌗 ",
		Color = "󰏘 ",
		Constant = "󰏿 ",
		Constructor = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = "󰜢 ",
		File = "󰈙 ",
		Folder = "󰉋 ",
		Function = "󰊕 ",
		Interface = " ",
		Key = "󰌋 ",
		Keyword = " ",
		Method = "󰆧 ",
		Module = " ",
		Namespace = "󰌗 ",
		Null = "󰟢 ",
		Number = "󰎠 ",
		Object = "󰅩 ",
		Operator = "󰆕 ",
		Package = " ",
		Property = "󰜢 ",
		Reference = "󰈇 ",
		Snippet = " ",
		String = "󰀬 ",
		Struct = "󰌗 ",
		Text = "󰉿 ",
		TypeParameter = " ",
		Unit = "󰑭 ",
		Value = "󰎠 ",
		Variable = "󰀫 ",
	},
	git = {
		LineAdded = "",
		LineModified = "",
		LineRemoved = "",
		FileDeleted = "",
		FileIgnored = "◌",
		FileRenamed = "",
		FileStaged = "S",
		FileUnmerged = "",
		FileUnstaged = "",
		FileUntracked = "U",
		Diff = "",
		Repo = "",
		Octoface = "",
		Branch = "",
	},
	diagnostics = {
		Error = "󰅙",
		Warn = "",
		Info = "",
		Hint = "",
		Debug = "",
		Trace = "✎",
	},
}

return M