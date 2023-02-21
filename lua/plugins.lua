return {
	{
		'hood/popui.nvim',
		lazy = false,
		dependencies = { 'RishabhRD/popfix' },
		config = function() vim.ui.input = require 'popui.input-overrider' end,
	},
}
