-- Continue reading configuration even if it contains an error
local function prequire(...)
	local ok, ret = pcall(require, ...)
	if not ok then
		print('Error: require("' .. ... .. '") failed')
		return {}
	end
	return ret
end

local function merge_tables(table, new_keys)
	for key, value in pairs(new_keys) do
		table[key] = value
	end
end

local function augroup(name, autocmds)
	local group = vim.api.nvim_create_augroup(name, {})
	local g = { group = group }

	for _, value in ipairs(autocmds) do
		value.opts = value.opts or {}
		merge_tables(value.opts, g)
		value = vim.api.nvim_create_autocmd(value.event, value.opts or {})
	end

	return group
end

return {
	prequire = prequire,
	merge_tables = merge_tables,
	augroup = augroup,
}
