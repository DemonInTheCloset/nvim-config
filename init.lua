-- Faster Lua
local ok, _ = pcall(require, "impatient")
if not ok then
	print "Impatient.nvim is not available, maybe run :PackerSync?"
end

-- Constants
local user_util = require "user/util"
local prequire = user_util.prequire
local CONFIG_PATH = user_util.CONFIG_PATH
local g = vim.g
local opt = vim.opt
local fn = vim.fn

-- Enable Filetype Plugin
g.do_filetype_lua = 1 -- Use filetype.lua
-- g.did_load_filetypes = 1 -- Disable filetype.vim
vim.cmd "filetype plugin on"
g.mapleader = " "

-- Plugins
prequire "user/packer"

-- [[ nvim settings ]] --
-- Providers
g.python3_host_prog = CONFIG_PATH .. "/.venv/bin/python"
-- Disable unused
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

-- Appearance
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.colorcolumn = "80" -- Color column 80
opt.cursorline = true -- Highlight selected line
opt.wrap = false -- Long lines don't wrap
opt.splitright = true -- Vert splits to the right
g.gruvbox_italic = 1 -- Allow italic font

-- In list mode show tabs and leading and trailing spaces
opt.listchars = { tab = "==>", trail = "·", lead = "·" }

-- Colors
if fn.has "termguicolors" == 1 then
	opt.termguicolors = true -- Allow Truecolor Support
end
vim.cmd.colorscheme "gruvbox" -- Set colorscheme
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Folds
opt.foldmethod = "syntax"

-- Statusbar
opt.laststatus = 2 -- Statusbar is always visible
opt.cmdheight = 1 -- Small cmd bar

-- Global Tab and indentation settings
opt.smarttab = true -- Tabs are smarter
opt.autoindent = true -- Auto indent lines
opt.smartindent = true -- Indentation is smarter
opt.expandtab = true -- Change tabs to spaces
opt.tabstop = 4 -- A Tab is 4 spaces
opt.softtabstop = 0 -- No softtabs
opt.shiftwidth = 4 -- An indent is 4 spaces

-- Search settings
opt.path = ".,/usr/include,**"
opt.wildmenu = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true -- Search ignores cases
opt.smartcase = true -- Unless it has a capital letter

-- [[ Keymaps ]] --
local keymaps = prequire "user/keymaps"
if keymaps ~= nil then
	keymaps.vim_keys()
end

-- [[ augroups ]] --
prequire "user/augroups"
