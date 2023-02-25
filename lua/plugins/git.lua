return {
	{
		'lewis6991/gitsigns.nvim',
		lazy = false,
		name = 'gitsigns',
		config = true,
	},

	{
		'TimUntersberger/neogit',
		requires = { 'nvim-lua/plenary.nvim' },
		cmd = 'Neogit',
		config = true,
	},
}
