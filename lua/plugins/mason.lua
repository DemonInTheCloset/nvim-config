return {
	{
		"williamboman/mason.nvim",
		name = "mason",
		cmd = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		name = "mason-lspconfig",
		dependencies = { "mason", "lspconfig" },
		opts = { automatic_installation = true },
	},
}
