-- Setup keybindings
vim.g.mapleader = " "
-- Quickfix List
vim.keymap.set("n", "<leader>qo", "<cmd>Copen<CR>", { desc = "[Q]uickfix [O]pen" })
vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "[Q]uickfix [Q]uit" })
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>", { desc = "[Q]uickfix Next [J]" })
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>", { desc = "[Q]uickfix Previous [K]" })

-- Preview Images Using wezterm
vim.keymap.set("n", "<leader>p", function()
	if vim.fn.executable("wezterm") == 0 then
		error("wezterm not found in $PATH", 3)
	end

	local img_path = vim.fn.expand("<cfile>")
	local new_pane = [[!wezterm cli split-pane --]] .. require("user/util").get_config()["pane_side"]
	local open_image = [[ -- bash -c 'wezterm imgcat "]] .. img_path .. [[" ; read']]

	vim.cmd([[silent ]] .. new_pane .. open_image)
end, { desc = "Show [P]icture" })

-- Keep selection while indenting
vim.keymap.set("v", ">", ">gv", { desc = "Indent Selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Deindent Selection" })

-- Miscellaneous
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { desc = "Set [C]urrent [D]irectory" })

-- Diagnostics
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "[D]iagnostics Next [J]" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "[D]iagnostics Previous [K]" })

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.splitright = true

-- Global Tab and indentation settings
vim.opt.smarttab = true -- Tabs are smarter
vim.opt.autoindent = true -- Auto indent lines
vim.opt.smartindent = true -- Indentation is smarter
vim.opt.expandtab = true -- Change tabs to spaces
vim.opt.tabstop = 4 -- A Tab is 4 spaces
vim.opt.softtabstop = 0 -- No softtabs
vim.opt.shiftwidth = 4 -- An indent is 4 spaces

-- Search settings
vim.opt.path = ".,/usr/include,**"
vim.opt.wildmenu = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Search ignores cases
vim.opt.smartcase = true -- Unless it has a capital letter

-- Bootstrap Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load Plugins
require("lazy").setup("plugins", { defaults = { lazy = true } })

-- Set colorscheme
if vim.fn.has("termguicolors") then
	vim.g.termguicolors = true
end
vim.cmd.colorscheme("gruvbox-baby")
