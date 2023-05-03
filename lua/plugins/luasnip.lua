return {
	{
		'L3MON4D3/LuaSnip',
		name = 'luasnip',
		config = function()
			require('luasnip').config.setup { update_events = 'TextChanged,TextChangedI' }
		end,
	},
}
