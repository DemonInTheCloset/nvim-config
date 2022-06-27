-- Enable Filetype Plugin
vim.g.do_filetype_lua = 1 -- Use filetype.lua
-- vim.g.did_load_filetypes = 1 -- Disable filetype.vim
vim.cmd "filetype plugin on"
vim.g.mapleader = " "

local user_util = require "user.util"
local prequire = user_util.prequire

prequire "user/plugins"

-- [[ nvim settings ]] --
local CONFIG_PATH = (os.getenv "XDG_CONFIG_HOME" or (os.getenv "HOME" .. "/.config")) .. "/nvim"

-- Path to Python environment
vim.g.python3_host_prog = CONFIG_PATH .. "/.venv/bin/python"

-- Appearance
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.colorcolumn = "80" -- Color column 80
vim.opt.cursorline = true -- Highlight selected line
vim.opt.wrap = false -- Long lines don't wrap
vim.opt.signcolumn = "number" -- Merge line numbers with coc messages
vim.g.gruvbox_italic = 1 -- Allow italic font

-- In list mode show tabs and leading and trailing spaces
vim.opt.listchars = { tab = "==>", trail = "·", lead = "·" }

-- Colors
if vim.fn.has "termguicolors" == 1 then
	vim.o.termguicolors = true -- Allow Truecolor Support
end
vim.cmd "colorscheme gruvbox" -- Set colorscheme

-- Folds
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Statusbar
vim.o.laststatus = 2 -- Statusbar is always visible
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Global Tab and indentation settings
vim.o.smarttab = true -- Tabs are smarter
vim.opt.autoindent = true -- Auto indent lines
vim.opt.smartindent = true -- Indentation is smarter
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.tabstop = 4 -- A Tab is 4 spaces
vim.opt.softtabstop = 0 -- No softtabs
vim.opt.shiftwidth = 4 -- An indent is 4 spaces

-- Search settings
vim.o.path = ".,/usr/include,**"
vim.o.wildmenu = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true -- Search ignores cases
vim.o.smartcase = true -- Unless it has a capital letter

-- Options recommended by CoC
vim.o.updatetime = 300 -- Update every 300 ms
vim.o.timeoutlen = 200 -- Timeout after 200 ms
vim.o.hidden = true -- TextEdit might fail otherwise
vim.opt.shortmess:append "c" -- Don't pass messages to ins-completion-menu
vim.o.cmdheight = 3 -- Give more space for messages
vim.o.backup = false -- Some LSPs have problems with backups
vim.o.writebackup = false

-- [[ treesitter config ]] --
local treesitter = prequire "nvim-treesitter.configs"

treesitter.setup {
	ensure_installed = {
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
	},
	-- install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	indent = { enable = true },
}

-- [[ snippets ]] --
local luasnip = prequire "luasnip"
luasnip.config.setup { update_events = "TextChanged,TextChangedI" }

local luasnip_loader = prequire "luasnip.loaders.from_lua"
luasnip_loader.load { paths = CONFIG_PATH .. "/snippets" }

-- [[ nvim keymaps ]] --
-- Completion Snippets
vim.keymap.set({ "i", "s" }, "<C-n>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { noremap = true, silent = true })
vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice", { noremap = true })

-- Vim Dispatch
vim.keymap.set("n", "<leader>m<CR>", "<cmd>Make %<CR>", { noremap = true })
vim.keymap.set("n", "<leader>`<CR>", "<cmd>Dispatch %<CR>", { noremap = true })

-- Quickfix List
vim.keymap.set("n", "<leader>qo", "<cmd>Copen<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>", { noremap = true })

-- Diagnostics
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { noremap = true })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { noremap = true })

-- Telescope
local telescope_builtin = prequire "telescope.builtin"
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { noremap = true })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { noremap = true })
vim.keymap.set("n", "<leader>fq", telescope_builtin.quickfix, { noremap = true })

-- Keep selection while indenting
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- EasyAlign
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)", { noremap = false })

-- Miscellaneous
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { noremap = true })
vim.keymap.set("n", "<leader>git", "<cmd>Neogit<CR>", { noremap = true })

-- [[ nvim-cmp config ]] --
local cmp = prequire "cmp"

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm { select = true },
	},
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = prequire("lspkind").cmp_format { with_text = false, maxwidth = 50 },
	},
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- [[ LSP configuration ]] --
prequire "user/lspconfig"

-- [[ plugins ]] --
local colorizer = prequire "colorizer"
colorizer.setup({ "*" }, {
	RGB = true, -- #RGB hex codes
	RRGGBB = true, -- #RRGGBB hex codes
	names = false, -- "Name" codes like Blue
	RRGGBBAA = true, -- #RRGGBBAA hex codes
	rgb_fn = false, -- CSS rgb() and rgba() functions
	hsl_fn = false, -- CSS hsl() and hsla() functions
	css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode = "background", -- Set the display mode.
})

-- [[ telescope ]] --
local telescope = prequire "telescope"
local function ptelescope_load_extension(extension)
	local ok, _ = pcall(telescope.load_extension, extension)
	if not ok then
		print("Error[Telescope]: Failed to load " .. extension .. " extension")
	end
end

telescope.setup {
	extensions = {
		["ui-select"] = {
			prequire("telescope.themes").get_dropdown {},
		},
	},
}

ptelescope_load_extension "fzy_native"
ptelescope_load_extension "ui-select"

-- [[ neogit ]] --
prequire("neogit").setup()

-- [[ statusline ]] --
local statusline = prequire "lualine"

statusline.setup {
	options = {
		icons_enabled = true,
		theme = "gruvbox",

		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat" },
		lualine_y = { "filetype" },
		lualine_z = { "progress", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}

-- [[ augroups ]] --
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
			callback = vim.highlight.on_yank,
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
			pattern = "*/plugins.lua",
			command = "source <afile> | PackerCompile",
		},
	},
})
