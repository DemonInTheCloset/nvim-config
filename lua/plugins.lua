return {
	{
		'hood/popui.nvim',
		dependencies = { 'RishabhRD/popfix' },
	},

	{
		'numToStr/FTerm.nvim',
		name = 'FTerm',
		keys = {
			{ '<leader>to', function() require('FTerm').open() end, desc = '[T]erminal [O]pen' },
			{ '<leader>tc', function() require('FTerm').close() end, desc = '[T]erminal [C]lose' },
			{ '<leader>te', function() require('FTerm').exit() end, desc = '[T]erminal [E]xit' },
		},
		opts = {},
	},
}
