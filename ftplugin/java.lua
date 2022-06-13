local prequire = require("user.util").prequire

local jdtls = prequire "jdtls"

local function scandir(dir)
	local pfile = io.popen('ls -a "' .. dir .. '"', "r")

	if not pfile then
		return {}
	end

	local i = 0
	local t = {}
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end

	return t
end

local function find_equinox_launcher(install)
	local launcher = "org.eclipse.equinox.launcher_"
	local plugins = install .. "/jdtls/plugins/"
	for _, filename in ipairs(scandir(plugins)) do
		if filename:sub(1, #launcher) == launcher then
			return plugins .. filename
		end
	end
end

-- TODO: Use .git / mvnw / gradlew to find the project name
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.XDG_DATA_HOME .. "/nvim-jdtls/" .. project_name
-- FIXME: Error out outside Linux
-- Copy gloal config if local down't exist
-- local global_config = jdtls_install .. "/jdtls/config_linux/config.ini"
local jdtls_install = "/usr/share/java"
local config_dir = vim.env.XDG_DATA_HOME .. "/jdtls/config"
-- TODO: programatically find this file
local jdtls_jar = find_equinox_launcher(jdtls_install)

if not jdtls_jar then
	print("[ERROR] Couldn't find equinox launcher in " .. jdtls_install)
	return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		jdtls_jar,

		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},

	-- Run my on attach function
	on_attach = prequire("user.lspconfig").on_attach,

	-- TODO: Maybe change
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = prequire("jdtls.setup").find_root { ".git", "mvnw", "gradlew" },

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
