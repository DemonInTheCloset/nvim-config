-- Enable Filetype Plugin
vim.g.do_filetype_lua = 1 -- Use filetype.lua
-- vim.g.did_load_filetypes = 1 -- Disable filetype.vim
vim.cmd "filetype plugin on"
vim.g.mapleader = " "

local user_util = require "user/util"
local prequire = user_util.prequire

prequire "user/plugins"

-- [[ nvim settings ]] --
local HOME_PATH = os.getenv "HOME"
local CONFIG_PATH = (os.getenv "XDG_CONFIG_HOME" or HOME_PATH .. "/.config") .. "/nvim"

-- Providers
vim.g.python3_host_prog = CONFIG_PATH .. "/.venv/bin/python"
-- Disable unused
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

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
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
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

statusline.setup {}

-- [[ augroups ]] --
prequire "user/augroups"
