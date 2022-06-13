vim.filetype.add {
	extension = {
		h = "c",
	},
	filename = {
		["newsboat/urls"] = "newsboat",
		["mbsyncrc"] = "mbsync",
	},
	pattern = {
		["/dev/shm/pass.*/?.*.txt"] = "pass",
		["/tmp/pass.*/?.*.txt"] = "pass",
		[(vim.env.TMPDIR or "") .. "/pass.*/?.*.txt"] = "pass",
		[(vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")) .. "/zsh"] = "zsh",
	},
}
