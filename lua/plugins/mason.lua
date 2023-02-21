return {
    {
        "williamboman/mason.nvim",
        name = "mason",
        cmd = { "Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        name = "mason-lspconfig",
        dependencies = { "mason", "lspconfig" },
        opts = { automatic_installation = true },
    },
}
