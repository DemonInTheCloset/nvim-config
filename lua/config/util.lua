-- Merge two tables by overwritting with the values in new_keys
---@param table table The table to modify
---@param new_keys table The new keys to add to the table
---@return table # The modified table (no copy is made)
local function merge_tables(table, new_keys)
	for key, value in pairs(new_keys) do
		table[key] = value
	end
	return table
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

return {
	merge_tables = merge_tables,
	augroup = augroup,
}
