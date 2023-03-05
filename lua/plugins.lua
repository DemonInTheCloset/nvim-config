return {
	{
		'hood/popui.nvim',
		dependencies = { 'RishabhRD/popfix' },
	},

	{
		'numToStr/FTerm.nvim',
		name = 'FTerm',
		keys = function()
			local fterm = require 'FTerm'
			local function oneshot(opts)
				return function() fterm.scratch(opts) end
			end
			return {
				{ '<leader>tt', fterm.toggle, desc = '[T]erminal [T]oggle' },
				{ '<leader>to', fterm.open, desc = '[T]erminal [O]pen' },
				{ '<leader>tc', fterm.close, desc = '[T]erminal [C]lose' },
				{ '<leader>te', fterm.exit, desc = '[T]erminal [E]xit' },
				{ '<leader>tg', oneshot { cmd = 'lazygit' }, desc = '[T]erminal lazy[G]it' },
			}
		end,
		opts = {},
	},
}
