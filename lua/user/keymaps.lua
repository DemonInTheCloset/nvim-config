-- [[ Vim Remaps ]]
local function vim_keys()
	-- Quickfix List
	vim.keymap.set("n", "<leader>qo", "<cmd>Copen<CR>", { desc = "[Q]uickfix [O]pen" })
	vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>", { desc = "[Q]uickfix [Q]uit" })
	vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>", { desc = "[Q]uickfix Next [J]" })
	vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>", { desc = "[Q]uickfix Previous [K]" })

	-- Preview Images Using wezterm
	vim.keymap.set("n", "<leader>p", function()
		if vim.fn.executable "wezterm" == 0 then
			error("wezterm not found in $PATH", 3)
		end

		local img_path = vim.fn.expand "<cfile>"
		local new_pane = [[!wezterm cli split-pane --]]
			.. require("user/util").get_config()["pane_side"]
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
	vim.keymap.set(
		"n",
		"<leader>dk",
		vim.diagnostic.goto_prev,
		{ desc = "[D]iagnostics Previous [K]" }
	)

	-- Run Jaq
	vim.keymap.set("n", "<leader>j", function()
		if vim.bo.filetype == "Jaq" then
			vim.cmd.q()
		end

		vim.cmd.Jaq()
	end, { desc = "Run [J]aq" })
end

-- [[ Plugin remaps ]]
-- Completion Snippets
local function luasnip_keys(luasnip)
	vim.keymap.set({ "i", "s" }, "<C-n>", function()
		if luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		end
	end, { silent = true, desc = "Expand/Jump to [N]ext" })
	vim.keymap.set({ "i", "s" }, "<C-p>", function()
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		end
	end, { silent = true, desc = "Jump to [P]revious" })
	vim.keymap.set("i", "<C-u>", require "luasnip.extras.select_choice", { desc = "Select Choice" })
end

-- Vim Dispatch
local function dispatch_keys()
	vim.keymap.set("n", "<leader>m<CR>", "<cmd>Make %<CR>", { desc = "[M]ake this file" })
	vim.keymap.set("n", "<leader>`<CR>", "<cmd>Dispatch %<CR>", { desc = "Dispatch this file" })
end

-- Telescope
local function telescope_keys(telescope_builtin)
	vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "[F]ind [G]rep" })
	vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[F]ind [H]elp" })
	vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "[F]ind [B]uffer" })
	vim.keymap.set(
		"n",
		"<leader>fd",
		telescope_builtin.diagnostics,
		{ desc = "[F]ind [D]iagnostics" }
	)
	vim.keymap.set("n", "<leader>fq", telescope_builtin.quickfix, { desc = "[F]ind [Q]uickfix" })
end

-- EasyAlign
local function easyalign_keys()
	vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)", { desc = "[G]o to [A]lign" })
end

-- Neogit
local function neogit_keys()
	local neogit = require "neogit"
	vim.keymap.set("n", "<leader>git", function()
		neogit.open()
	end, { desc = "Open [git]" })
end

return {
	dispatch_keys = dispatch_keys,
	easyalign_keys = easyalign_keys,
	luasnip_keys = luasnip_keys,
	neogit_keys = neogit_keys,
	telescope_keys = telescope_keys,
	vim_keys = vim_keys,
}
