-- [[ Vim Remaps ]]
local function vim_keys()
	-- Quickfix List
	vim.keymap.set("n", "<leader>qo", "<cmd>Copen<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>", { noremap = true })

	-- Keep selection while indenting
	vim.keymap.set("v", ">", ">gv", { noremap = true })
	vim.keymap.set("v", "<", "<gv", { noremap = true })

	-- Miscellaneous
	vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { noremap = true })

	-- Diagnostics
	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { noremap = true })
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { noremap = true })
end

-- [[ Plugin remaps ]]
-- Completion Snippets
local function luasnip_keys(luasnip)
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
end

-- Vim Dispatch
local function dispatch_keys()
	vim.keymap.set("n", "<leader>m<CR>", "<cmd>Make %<CR>", { noremap = true })
	vim.keymap.set("n", "<leader>`<CR>", "<cmd>Dispatch %<CR>", { noremap = true })
end

-- Telescope
local function telescope_keys(telescope_builtin)
	vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { noremap = true })
	vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { noremap = true })
	vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true })
	vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { noremap = true })
	vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { noremap = true })
	vim.keymap.set("n", "<leader>fq", telescope_builtin.quickfix, { noremap = true })
end

-- EasyAlign
local function easyalign_keys()
	vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)", { noremap = false })
end

-- Neogit
local function neogit_keys()
	vim.keymap.set("n", "<leader>git", "<cmd>Neogit<CR>", { noremap = true })
end

return {
	dispatch_keys = dispatch_keys,
	easyalign_keys = easyalign_keys,
	luasnip_keys = luasnip_keys,
	neogit_keys = neogit_keys,
	telescope_keys = telescope_keys,
	vim_keys = vim_keys,
}