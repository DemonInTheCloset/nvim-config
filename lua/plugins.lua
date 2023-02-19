return {
	"folke/which-key.nvim",
	{ "nvim-treesitter/nvim-treesitter-context", dependencies = { "nvim-treesitter" } },

	{
		"hood/popui.nvim",
		dependencies = { "RishabhRD/popfix" },
		config = function()
			vim.ui.input = require("popui.input-overrider")
		end,
	},

	{ "lewis6991/gitsigns.nvim", name = "gitsigns" },

	{
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim" },
		cmd = { "Neogit" },
	},

	{
		"nvim-telescope/telescope.nvim",
        cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		name = "telescope",
		opts = function()
			local telescope_builtin = require("telescope.builtin")
			-- Keymaps
			vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "[F]ind [G]rep" })
			vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[F]ind [H]elp" })
			vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "[F]ind [B]uffer" })
			vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "<leader>fq", telescope_builtin.quickfix, { desc = "[F]ind [Q]uickfix" })
			-- Settings
			return {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			}
		end,
	},
}
