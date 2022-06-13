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
local user_lspconfig = prequire "user.lspconfig"

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

-- [[ rust-tools ]]
local rust_tools = prequire "rust-tools"
rust_tools.setup {
	-- Send these options to NeoVim
	server = {
		on_attach = user_lspconfig.on_attach,
		capabilities = user_lspconfig.capabilities,
	},
}

-- [[ null_ls ]] --
local lsp_formatting = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = prequire "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.latexindent,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.reorder_python_imports.with {
			extra_args = { "--application-directories=.:src" },
		},
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.taplo,

		null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.diagnostics.chktex,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.trail_space,
		-- null_ls.builtins.diagnostics.vulture,
		null_ls.builtins.diagnostics.zsh,

		null_ls.builtins.code_actions.shellcheck,
	},
	-- Format On Save
	on_attach = function(client, bufnr)
		if client.supports_method "textDocument/formatting" then
			vim.api.nvim_clear_autocmds { group = lsp_formatting, buffer = bufnr }
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = lsp_formatting,
				buffer = bufnr,
				callback = vim.lsp.buf.formatting_seq_sync,
			})
		end
	end,
}

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
local open_folds = vim.api.nvim_create_augroup("OpenFolds", {})
vim.api.nvim_create_autocmd(
	"BufRead",
	{ group = open_folds, pattern = "*", command = "silent! %foldopen!" }
)

local file_type_override = vim.api.nvim_create_augroup("FileTypeOverride", {})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "c" },
	-- Set indent width to 8 spaces and use tabs
	callback = function()
		vim.bo.tabstop = 8
		vim.bo.shiftwidth = 8
		vim.bo.expandtab = false
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "porth", "haskell", "markdown", "java" },
	-- Set indent width to 2 spaces
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = file_type_override,
	pattern = { "markdown", "tex" },
	-- Set wrap at 80 characters
	callback = function()
		vim.bo.textwidth = 80
		vim.wo.wrap = true
	end,
})
vim.api.nvim_create_autocmd("TermOpen", {
	group = file_type_override,
	pattern = "*",
	-- Don't show line numbers
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

local dispatch_compiler = vim.api.nvim_create_augroup("DispatchCompiler", {})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "java",
	callback = function()
		vim.b.dispatch = "gradle build"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "python",
	callback = function()
		vim.b.dispatch = "mypy %"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "markdown",
	callback = function()
		vim.b.dispatch = "pandoc --pdf-engine=xelatex -f markdown % -o %.pdf"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = { "tex", "plaintex" },
	callback = function()
		vim.b.dispatch = "latexmk -pvc -pdflua %"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = { "sh", "bash" },
	command = ":compiler shellcheck",
})
vim.api.nvim_create_autocmd("FileType", {
	group = dispatch_compiler,
	pattern = "porth",
	command = ":compiler porth",
})

local template_files = vim.api.nvim_create_augroup("TemplateFiles", {})
vim.api.nvim_create_autocmd("BufNewFile", {
	group = template_files,
	pattern = { "*.py", "*.zsh" },
	callback = function(vals)
		local extension = vals["match"]:match "[^.]+$"
		-- Look for a file named skeleton.extension (ie. skeleton.py)
		-- in ~/.config/nvim/templates/ and read it into the current file
		vim.cmd("0r ~/.config/nvim/templates/skeleton." .. extension)
	end,
})

local packer_update = vim.api.nvim_create_augroup("PackerUpdate", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = packer_update,
	pattern = "*/plugins.lua",
	callback = function()
		-- Set plugins as not loaded
		package.loaded.plugins = nil
		prequire "user/plugins"
		local packer = prequire "packer"
		packer.compile()
	end,
})
