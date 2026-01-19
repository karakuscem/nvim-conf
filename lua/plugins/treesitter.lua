return {
    {
        "nvim-treesitter/nvim-treesitter",
        pin = true, -- Don't auto-update (pinned in lazy-lock.json)
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                pin = true,
            },
        },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                -- ensure these language parsers are installed
                ensure_installed = {
                    "json",
                    "python",
                    "ron",
                    "javascript",
                    "haskell",
                    "query",
                    "typescript",
                    "tsx",
                    "rust",
                    "zig",
                    "php",
                    "yaml",
                    "html",
                    "css",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "lua",
                    "vim",
                    "vimdoc",
                    "c",
                    "asm",
                    "dockerfile",
                    "gitignore",
                    "astro",
                },
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                },
            })
        end
    }
}
