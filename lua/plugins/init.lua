return {
    -- {
    --     "nvim-lua/plenary.nvim",
    --     name = "plenary"
    -- },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- Disable netrw (recommended)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = {
                    width = 30,
                },
                filters = {
                    dotfiles = false,
                },
            })
        end,
    },
}
