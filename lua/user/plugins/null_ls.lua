-- [[ null_ls ]] --
local null_ls = require "null-ls"
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.nginx_beautifier,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.dfmt,
        null_ls.builtins.formatting.reorder_python_imports.with {
            extra_args = { "--application-directories=.:src" },
        },
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.taplo,

        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.chktex,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.trail_space,
        -- null_ls.builtins.diagnostics.vulture,
        null_ls.builtins.diagnostics.zsh,

        null_ls.builtins.code_actions.shellcheck,
    },
    -- Format Keybinding
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.keymap.set(
                "n",
                "<leader>w",
                vim.lsp.buf.format,
                { noremap = true, buffer = bufnr }
            )
        end
    end,
}
