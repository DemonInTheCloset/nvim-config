return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = false,
        name = "null-ls",
        dependencies = { "mason" },
        opts = function()
            local null_ls = require("null-ls")

            return {
                sources = {
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.diagnostics.statix,
                    null_ls.builtins.diagnostics.zsh,

                    null_ls.builtins.formatting.clang_format,
                    null_ls.builtins.formatting.just,
                    null_ls.builtins.formatting.nginx_beautifier,
                    null_ls.builtins.formatting.nixpkgs_fmt,
                    null_ls.builtins.formatting.ruff,
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.shellharden,
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.taplo,
                    null_ls.builtins.formatting.trim_whitespace,
                    null_ls.builtins.formatting.yamlfmt,
                    null_ls.builtins.formatting.zigfmt,

                    null_ls.builtins.hover.printenv,
                },
            }
        end,
    },
}
