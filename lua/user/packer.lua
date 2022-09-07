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
                require "user/plugins/colorizer"
            end,
        }

        -- Jump hints
        use {
            "unblevable/quick-scope",
            config = function()
                vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
            end,
        }

        -- Show enclosing Scope at the Top
        use {
            "nvim-treesitter/nvim-treesitter-context",
            config = function()
                require("treesitter-context").setup {}
            end,
        }

        -- Highlight Words and Lines under the cursor
        use {
            "yamatsum/nvim-cursorline",
            config = function()
                require("nvim-cursorline").setup {
                    cursorline = {
                        enable = true,
                        timeout = 500,
                        number = true,
                    },
                    cursorword = {
                        enable = true,
                        min_length = 3,
                        hl = { underline = true },
                    },
                }
            end,
        }

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

        -- Run Tests
        use {
            "nvim-neotest/neotest",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
                "rouge8/neotest-rust",
            },
            config = function()
                require("neotest").setup {
                    adapters = {
                        require "neotest-rust",
                    },
                }
            end,
        }
        use {
            "CRAG666/code_runner.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("code_runner").setup {
                    mode = "tab",
                    focus = false,
                    -- put here the commands by filetype
                    filetype = {
                        rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
                    },
                }
            end,
        }
        use {
            "is0n/jaq-nvim",
            config = function()
                require("jaq-nvim").setup {
                    cmds = {
                        external = {
                            rust = "cargo test",
                        },
                    },

                    behavior = {
                        -- Default type
                        default = "terminal",
                        -- Start in insert mode
                        startinsert = false,
                        -- Use `wincmd p` on startup
                        wincmd = false,
                        -- Auto-save files
                        autosave = false,
                    },

                    ui = {
                        terminal = {
                            -- Window position
                            position = "vert",
                            -- Window size
                            size = 80,
                            -- Disable line numbers
                            line_no = true,
                        },

                        quickfix = {
                            -- Window position
                            position = "bot",
                            -- Window size
                            size = 10,
                        },
                    },
                }
            end,
        }

        -- Git integration
        -- use "tpope/vim-fugitive"
        use {
            "TimUntersberger/neogit",
            requires = { { "nvim-lua/plenary.nvim" } },
            config = function()
                require("neogit").setup {}
                require("user/keymaps").neogit_keys()
            end,
        }
        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end,
        }

        -- Language Server configuration
        use {
            "neovim/nvim-lspconfig",
            config = function()
                require "user/plugins/lspconfig"
            end,
        }
        use "onsails/lspkind-nvim"
        use "mfussenegger/nvim-jdtls" -- Java JDTLS support
        use {
            "simrat39/rust-tools.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
            config = function()
                require "user/plugins/rust_tools"
            end,
        }
        use {
            "p00f/clangd_extensions.nvim",
            config = function()
                require "clangd_extensions"
            end,
        }

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
                require "user/plugins/cmp"
            end,
        }

        -- Formatting support
        use {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require "user/plugins/null_ls"
            end,
        }

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
                require "user/plugins/treesitter"
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

        use "nvim-lua/plenary.nvim"
        -- Fuzzy find
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-telescope/telescope-ui-select.nvim" },
                { "nvim-telescope/telescope-fzy-native.nvim" },
            },
            config = function()
                require "user/plugins/telescope"
            end,
        }

        use {
            "hood/popui.nvim",
            requires = { { "RishabhRD/popfix" } },
            config = function()
                vim.ui.input = require "popui.input-overrider"
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
