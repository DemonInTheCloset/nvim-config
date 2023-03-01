-- Merge two tables by overwritting with the values in new_keys
---@param table table The table to modify
---@param new_keys table The new keys to add to the table
local function merge_tables(table, new_keys)
	for key, value in pairs(new_keys) do
		table[key] = value
	end
end

-- Create an Augroup
---@param name string The name of the augroup
---@param autocmds table[] The autocmds to add to the augroup
---@param opts table? The augroup options
local function augroup(name, autocmds, opts)
	local group = vim.api.nvim_create_augroup(name, opts or {})
	local g = { group = group }

	for _, value in ipairs(autocmds) do
		value.opts = value.opts or {}
		merge_tables(value.opts, g)
		value = vim.api.nvim_create_autocmd(value.event, value.opts or {})
	end

	return group
end

augroup('OpenFolds', {
	{
		event = 'BufRead',
		opts = {
			pattern = '*',
			command = 'silent! %foldopen!',
		},
	},
})

augroup('FTOverride', {
	{
		event = 'FileType',
		opts = {
			pattern = { 'c', 'cpp' },
			-- Set indent width to 8 spaces and use tabs
			callback = function()
				vim.bo.tabstop = 8
				vim.bo.shiftwidth = 8
				vim.bo.expandtab = false
			end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = { 'porth', 'haskell', 'markdown', 'java', 'nix' },
			-- Set indent width to 2 spaces
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
			end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = { 'markdown', 'tex' },
			-- Set wrap at 80 characters
			callback = function()
				vim.bo.textwidth = 80
				vim.wo.wrap = true
			end,
		},
	},
	{
		event = 'TermOpen',
		opts = {
			pattern = '*',
			-- Don't show line numbers
			callback = function()
				vim.wo.number = false
				vim.wo.relativenumber = false
			end,
		},
	},
})

augroup('SetDispatch', {
	{
		event = 'FileType',
		opts = {
			pattern = 'java',
			callback = function() vim.b.dispatch = 'gradle build' end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = 'python',
			callback = function() vim.b.dispatch = 'mypy %' end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = 'markdown',
			callback = function() vim.b.dispatch = 'pandoc --pdf-engine=xelatex -f markdown % -o %.pdf' end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = { 'tex', 'plaintex' },
			callback = function() vim.b.dispatch = 'latexmk -pvc -pdflua %' end,
		},
	},
	{
		event = 'FileType',
		opts = {
			pattern = 'porth',
			command = ':compiler porth',
		},
	},
})

augroup('HighlightOnYank', {
	{
		event = 'TextYankPost',
		opts = {
			pattern = '*',
			callback = function()
				vim.highlight.on_yank {
					higroup = (
						vim.fn['hlexists'] 'HighlightedyankRegion' > 0 and 'HighlightedyankRegion' or 'IncSearch'
					),
					timeout = 200,
				}
			end,
		},
	},
})

augroup('TemplateFiles', {
	{
		event = 'BufNewFile',
		opts = {
			pattern = { '*.py', '*.zsh' },
			callback = function(vals)
				local extension = vals['match']:match '[^.]+$'
				-- Look for a file named skeleton.extension (ie. skeleton.py)
				-- in ~/.config/nvim/templates/ and read it into the current file
				vim.cmd('0r ~/.config/nvim/templates/skeleton.' .. extension)
			end,
		},
	},
})

augroup('PackerUpdate', {
	{
		event = 'BufWritePost',
		opts = {
			pattern = 'packer.lua',
			command = 'source <afile> | PackerCompile',
		},
	},
})

augroup('JumpToLastLine', {
	{
		event = 'BufReadPost',
		opts = {
			pattern = '*',
			callback = function()
				if vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
					vim.cmd [[execute "normal! g'\""]]
				end
			end,
		},
	},
})
