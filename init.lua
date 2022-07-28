-- Enable Filetype Plugin
vim.g.do_filetype_lua = 1 -- Use filetype.lua
-- vim.g.did_load_filetypes = 1 -- Disable filetype.vim
vim.cmd "filetype plugin on"
vim.g.mapleader = " "

local user_util = require "user/util"
local prequire = user_util.prequire

prequire "user/plugins"

-- [[ nvim settings ]] --
local CONFIG_PATH = user_util.CONFIG_PATH

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
vim.opt.foldmethod = "syntax"

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

-- [[ Keymaps ]] --
local keymaps = prequire "user/keymaps"
if keymaps ~= nil then
	keymaps.vim_keys()
end

-- [[ LSP configuration ]] --
prequire "user/lspconfig"

-- [[ augroups ]] --
prequire "user/augroups"
