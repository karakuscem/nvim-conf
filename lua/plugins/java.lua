return {
    -- nvim-jdtls: Enhanced Java support
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        dependencies = {
            "mfussenegger/nvim-dap", -- Debug Adapter Protocol
        },
    },

    -- nvim-dap: Debug Adapter Protocol client
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            -- UI for nvim-dap
            {
                "rcarriga/nvim-dap-ui",
                dependencies = { "nvim-neotest/nvim-nio" },
                config = function()
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup()

                    -- Automatically open/close DAP UI
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close()
                    end
                end,
            },
            -- Virtual text for debugger
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    require("nvim-dap-virtual-text").setup()
                end,
            },
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
        },
    },
}
