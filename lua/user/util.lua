-- Useful Constants
local HOME_PATH = vim.env.HOME
local CONFIG_PATH = (vim.env.XDG_CONFIG_HOME or HOME_PATH .. "/.config") .. "/nvim"

-- Continue reading configuration even if it contains an error
local function prequire(module)
    local ok, ret = pcall(require, module)
    if not ok then
        print('Error: require("' .. module .. '") failed')
        return nil
    end
    return ret
end

-- Merge two tables by overwritting with the values in new_keys
local function merge_tables(table, new_keys)
    for key, value in pairs(new_keys) do
        table[key] = value
    end
end

-- Create an Augroup
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

-- Read Configuration
local function get_config()
    local config = prequire "user/default"
    if config == nil then
        return {}
    end

    local ok, config_override = pcall(require, "user/config")
    if ok then
        merge_tables(config, config_override)
    end

    return config
end

return {
    HOME_PATH = HOME_PATH,
    CONFIG_PATH = CONFIG_PATH,
    prequire = prequire,
    merge_tables = merge_tables,
    augroup = augroup,
    get_config = get_config,
}
