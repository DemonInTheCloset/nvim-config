-- Continue reading configuration even if it contains an error
local function prequire(...)
	local ok, ret = pcall(require, ...)
	if not ok then
		print('Error: require("' .. ... .. '") failed')
		return {}
	end
	return ret
end

return {
	prequire = prequire,
}
