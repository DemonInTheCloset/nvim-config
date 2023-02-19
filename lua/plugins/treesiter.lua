return {
    { "nvim-treesitter/nvim-treesitter-context", lazy = false, name = "treesitter-context", dependencies = { "nvim-treesitter" } },

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			-- Automatically install these parsers
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"rust",
			},
			-- Install parser for buffer
			auto_install = true,
			highlight = {
				enable = true,
			},
			incremental_selection = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
