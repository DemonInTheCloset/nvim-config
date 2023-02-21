return {
	{
		'nvim-telescope/telescope.nvim',
		name = 'telescope',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
		},
		cmd = 'Telescope',
		keys = function()
			local telescope_builtin = require 'telescope.builtin'
			return {
				{ '<leader>ff', telescope_builtin.find_files, desc = '[F]ind [F]iles' },
				{ '<leader>fg', telescope_builtin.live_grep, desc = '[F]ind [G]rep' },
				{ '<leader>fh', telescope_builtin.help_tags, desc = '[F]ind [H]elp' },
				{ '<leader>fb', telescope_builtin.buffers, desc = '[F]ind [B]uffer' },
				{ '<leader>fd', telescope_builtin.diagnostics, desc = '[F]ind [D]iagnostics' },
				{ '<leader>fq', telescope_builtin.quickfix, desc = '[F]ind [Q]uickfix' },
			}
		end,
		opts = function()
			-- Settings
			return {
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown {},
					},
				},
			}
		end,
	},
}
