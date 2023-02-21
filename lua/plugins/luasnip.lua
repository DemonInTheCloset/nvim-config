return {
	{
		'L3MON4D3/LuaSnip',
		name = 'luasnip',
		config = function()
			local luasnip = require 'luasnip'
			-- Keymaps
			vim.keymap.set({ 'i', 's' }, '<C-n>', function()
				if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
			end, { silent = true, desc = 'Expand/Jump to [N]ext' })
			vim.keymap.set({ 'i', 's' }, '<C-p>', function()
				if luasnip.jumpable(-1) then luasnip.jump(-1) end
			end, { silent = true, desc = 'Jump to [P]revious' })
			vim.keymap.set('i', '<C-u>', require 'luasnip.extras.select_choice', { desc = 'Select Choice' })
			-- Settings
			require('luasnip').config.setup { update_events = 'TextChanged,TextChangedI' }
		end,
	},
}
