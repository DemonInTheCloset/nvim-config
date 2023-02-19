return {
    {
        "hood/popui.nvim",
        lazy = false,
        dependencies = { "RishabhRD/popfix" },
        config = function()
            vim.ui.input = require("popui.input-overrider")
        end,
    },

    { "lewis6991/gitsigns.nvim",                 lazy = false, name = "gitsigns" },

    {
        "TimUntersberger/neogit",
        requires = { "nvim-lua/plenary.nvim" },
        cmd = "Neogit",
    },
}
