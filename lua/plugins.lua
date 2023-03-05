return {
	{
		'hood/popui.nvim',
		dependencies = { 'RishabhRD/popfix' },
	},

	{
		'numToStr/FTerm.nvim',
		name = 'FTerm',
		keys = function()
			return {
				{ '<leader>to', require('FTerm').open, desc = '[T]erminal [O]pen' },
				{ '<leader>tc', require('FTerm').close, desc = '[T]erminal [C]lose' },
				{ '<leader>te', require('FTerm').exit, desc = '[T]erminal [E]xit' },
			}
		end,
		opts = {},
	},
}
