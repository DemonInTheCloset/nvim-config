-- Bootstrap Packer if it isn't installed in the system
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
end

-- Plugins
return require("packer").startup {
	function(use)
		use "wbthomason/packer.nvim"

		-- Time tracking
		use "wakatime/vim-wakatime"
		use "ActivityWatch/aw-watcher-vim"

		-- Vim Profiling
		use { "tweekmonster/startuptime.vim", opt = true, cmd = { "StartupTime" } }
		use "lewis6991/impatient.nvim"

		-- ColorScheme
		use { "ellisonleao/gruvbox.nvim", requires = { { "rktjmp/lush.nvim" } } }

		-- Colorizer
		use {
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "*" }, {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					rgb_fn = false, -- CSS rgb() and rgba() functions
					hsl_fn = false, -- CSS hsl() and hsla() functions
					css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes: foreground, background
					mode = "background", -- Set the display mode.
				})
			end,
		}

		-- Jump hints
		use "unblevable/quick-scope"

		-- Align Text
		use {
			"junegunn/vim-easy-align",
			opt = true,
			cmd = { "<Plug>(EasyAlign)" },
			config = function()
				require("user/keymaps").easyalign_keys()
			end,
		}

		-- Async commands
		use {
			"tpope/vim-dispatch",
			opt = true,
			cmd = { "Dispatch", "Make", "Focus", "Start" },
			config = function()
				require("user/keymaps").dispatch_keys()
			end,
		}

		-- Git integration
		-- use "tpope/vim-fugitive"
		use {
			"TimUntersberger/neogit",
			requires = { { "nvim-lua/plenary.nvim" } },
			opt = true,
			cmd = { "Neogit" },
			config = function()
				require("neogit").setup()
				require("user/keymaps").neogit_keys()
			end,
		}

		-- Language Server configuration
		use "neovim/nvim-lspconfig"
		use "onsails/lspkind-nvim"
		use "mfussenegger/nvim-jdtls" -- Java JDTLS support
		use { "simrat39/rust-tools.nvim", requires = { { "nvim-lua/plenary.nvim" } } }
		use { "p00f/clangd_extensions.nvim" }

		-- Debugging
		use "mfussenegger/nvim-dap"

		-- Completion Support
		use "hrsh7th/cmp-nvim-lsp" -- Language server hints
		use "hrsh7th/cmp-buffer" -- Words from the buffer
		use "hrsh7th/cmp-path" -- Path like strings (ie. /usr/bin/nvim)
		use "hrsh7th/cmp-cmdline" -- Commands completion
		use "saadparwaiz1/cmp_luasnip" -- Snippet support
		use {
			"hrsh7th/nvim-cmp",
			config = function()
				-- [[ nvim-cmp config ]] --
				local cmp = require "cmp"
				cmp.setup {
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert {
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete {},
						["<C-e>"] = cmp.mapping.close(),
						["<CR>"] = cmp.mapping.confirm { select = true },
					},
					sources = cmp.config.sources({
						{ name = "nvim_lua" },
						{ name = "nvim_lsp" },
						{ name = "path" },
						{ name = "luasnip" },
					}, {
						{ name = "buffer" },
					}),
					formatting = {
						format = require("lspkind").cmp_format {
							with_text = false,
							maxwidth = 50,
						},
					},
				}

				-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline("/", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = "buffer" },
					},
				})

				-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				})
			end,
		}
		use "jose-elias-alvarez/null-ls.nvim" -- Formatting support

		-- Snippet support
		use {
			"L3MON4D3/LuaSnip",
			config = function()
				local CONFIG_PATH = require("user/util").CONFIG_PATH

				require("luasnip").config.setup { update_events = "TextChanged,TextChangedI" }
				require("luasnip.loaders.from_lua").load { paths = CONFIG_PATH .. "/snippets" }

				require("user/keymaps").luasnip_keys(require "luasnip")
			end,
		}

		-- StatusLine
		use {
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup {}
			end,
		}

		-- Filetype Highlighting
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				local ts_langs = {
					"bash",
					"bibtex",
					"c",
					"cmake",
					"comment",
					"cpp",
					"css",
					"d",
					"devicetree",
					"dockerfile",
					"dot",
					"elm",
					"haskell",
					"help",
					"html",
					"http",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"jsonc",
					"kotlin",
					"latex",
					"ledger",
					"llvm",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"org",
					"python",
					"query",
					"regex",
					"rust",
					"todotxt",
					"toml",
					"vim",
					"yaml",
				}

				require("nvim-treesitter.configs").setup {
					ensure_installed = ts_langs,
					-- install languages synchronously (only applied to `ensure_installed`)
					sync_install = false,
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
					incremental_selection = { enable = true },
					indent = { enable = true },
				}

				-- Treesitter Folds
				require("user/util").augroup("TreesitterFolds", {
					event = "Filetype",
					opts = {
						pattern = ts_langs,
						callback = function()
							vim.wo.foldmethod = "expr"
							vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
						end,
					},
				})
			end,
		}
		use { "baskerville/vim-sxhkdrc", ft = "sxhkdrc" }
		use { "chunkhang/vim-mbsync", ft = "mbsyncrc" }
		-- use "https://gitlab.com/DemonInTheCloset/porth-vim.git"

		use {
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.fn["mkdp#util#install"]()
			end,
		}

		-- Fuzzy find
		use "nvim-lua/plenary.nvim"
		use {
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-ui-select.nvim" },
				{ "nvim-telescope/telescope-fzy-native.nvim" },
			},
			config = function()
				local telescope = require "telescope"
				telescope.setup {
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown {},
						},
					},
				}

				require("user/keymaps").telescope_keys(require "telescope.builtin")

				local function ptelescope_load_extension(extension)
					local ok, _ = pcall(telescope.load_extension, extension)
					if not ok then
						print("Error[Telescope]: Failed to load " .. extension .. " extension")
					end
				end

				ptelescope_load_extension "fzy_native"
				ptelescope_load_extension "ui-select"
			end,
		}

		-- Do bootstrap
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = require("packer.util").float,
		},
		profile = {
			enable = true,
			threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
	},
}
