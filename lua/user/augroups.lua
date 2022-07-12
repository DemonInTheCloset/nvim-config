local user_util = require "user/util"

user_util.augroup("OpenFolds", {
	{
		event = "BufRead",
		opts = {
			pattern = "*",
			command = "silent! %foldopen!",
		},
	},
})

user_util.augroup("FTOverride", {
	{
		event = "FileType",
		opts = {
			pattern = { "c", "cpp" },
			-- Set indent width to 8 spaces and use tabs
			callback = function()
				vim.bo.tabstop = 8
				vim.bo.shiftwidth = 8
				vim.bo.expandtab = false
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = { "porth", "haskell", "markdown", "java" },
			-- Set indent width to 2 spaces
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = { "markdown", "tex" },
			-- Set wrap at 80 characters
			callback = function()
				vim.bo.textwidth = 80
				vim.wo.wrap = true
			end,
		},
	},
	{
		event = "TermOpen",
		opts = {
			pattern = "*",
			-- Don't show line numbers
			callback = function()
				vim.wo.number = false
				vim.wo.relativenumber = false
			end,
		},
	},
})

user_util.augroup("SetDispatch", {
	{
		event = "FileType",
		opts = {
			pattern = "java",
			callback = function()
				vim.b.dispatch = "gradle build"
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = "python",
			callback = function()
				vim.b.dispatch = "mypy %"
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = "markdown",
			callback = function()
				vim.b.dispatch = "pandoc --pdf-engine=xelatex -f markdown % -o %.pdf"
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = { "tex", "plaintex" },
			callback = function()
				vim.b.dispatch = "latexmk -pvc -pdflua %"
			end,
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = { "sh", "bash" },
			command = ":compiler shellcheck",
		},
	},
	{
		event = "FileType",
		opts = {
			pattern = "porth",
			command = ":compiler porth",
		},
	},
})

user_util.augroup("HighlightOnYank", {
	{
		event = "TextYankPost",
		opts = {
			pattern = "*",
			callback = function()
				vim.highlight.on_yank {
					higroup = (
						vim.fn["hlexists"] "HighlightedyankRegion" > 0
							and "HighlightedyankRegion"
						or "IncSearch"
					),
					timeout = 200,
				}
			end,
		},
	},
})

user_util.augroup("TemplateFiles", {
	{
		event = "BufNewFile",
		opts = {
			pattern = { "*.py", "*.zsh" },
			callback = function(vals)
				local extension = vals["match"]:match "[^.]+$"
				-- Look for a file named skeleton.extension (ie. skeleton.py)
				-- in ~/.config/nvim/templates/ and read it into the current file
				vim.cmd("0r ~/.config/nvim/templates/skeleton." .. extension)
			end,
		},
	},
})

user_util.augroup("PackerUpdate", {
	{
		event = "BufWritePost",
		opts = {
			pattern = "plugins.lua",
			command = "source <afile> | PackerCompile",
		},
	},
})
