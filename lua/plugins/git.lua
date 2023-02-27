return {
	{
		'lewis6991/gitsigns.nvim',
		lazy = false,
		name = 'gitsigns',
		config = true,
	},

	{
		'TimUntersberger/neogit',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = 'Neogit',
		config = true,
	},
}
