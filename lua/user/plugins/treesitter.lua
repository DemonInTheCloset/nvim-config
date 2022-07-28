local ts_langs = {
	"bash",
	"bibtex",
	"c",
	"cmake",
	"comment",
	"cpp",
	"css",
	"d",
	"devicetree",
	"dockerfile",
	"dot",
	"elm",
	"haskell",
	"help",
	"html",
	"http",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"jsonc",
	"kotlin",
	"latex",
	"ledger",
	"llvm",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"org",
	"python",
	"query",
	"regex",
	"rust",
	"todotxt",
	"toml",
	"vim",
	"yaml",
}

require("nvim-treesitter.configs").setup {
	ensure_installed = ts_langs,
	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	indent = { enable = true },
}

-- Treesitter Folds
require("user/util").augroup("TreesitterFolds", {
	event = "Filetype",
	opts = {
		pattern = ts_langs,
		callback = function()
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},
})
