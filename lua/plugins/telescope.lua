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
			local ok, telescope_builtin = pcall(require, 'telescope.builtin')

			local function is_repo(cmd)
				vim.fn.system(cmd)
				return vim.v.shell_error == 0
			end

			local function find_root(name)
				local dot_repo_path = vim.fn.finddir(name, '.;')
				return vim.fn.fnamemodify(dot_repo_path, ':h')
			end

			local function git_live_grep()
				local opts = {}
				if is_repo 'git rev-parse --is-inside-work-tree' then
					opts.cwd = find_root '.git'
				elseif is_repo 'hg root' then
					opts.cwd = find_root '.hg'
				end

				telescope_builtin.live_grep(opts)
			end

			local function git_find_files()
				local opts = {}
				if is_repo 'git rev-parse --is-inside-work-tree' then
					opts.cwd = find_root '.git'
				elseif is_repo 'hg root' then
					opts.cwd = find_root '.hg'
				end

				telescope_builtin.find_files(opts)
			end

			if ok then
				return {
					{ '<leader>gf', git_find_files, desc = '[G]it [F]iles' },
					{ '<leader>gg', git_live_grep, desc = '[G]it [G]rep' },
					{ '<leader>ff', telescope_builtin.find_files, desc = '[F]ind [F]iles' },
					{ '<leader>fg', telescope_builtin.live_grep, desc = '[F]ind [G]rep' },
					{ '<leader>fh', telescope_builtin.help_tags, desc = '[F]ind [H]elp' },
					{ '<leader>fb', telescope_builtin.buffers, desc = '[F]ind [B]uffer' },
					{ '<leader>fd', telescope_builtin.diagnostics, desc = '[F]ind [D]iagnostics' },
					{ '<leader>fq', telescope_builtin.quickfix, desc = '[F]ind [Q]uickfix' },
				}
			end
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
