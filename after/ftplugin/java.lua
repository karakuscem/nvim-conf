-- Java LSP configuration using nvim-jdtls
-- This file is loaded automatically for .java files

local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify("nvim-jdtls not found", vim.log.levels.WARN)
    return
end

-- Paths
local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local java_debug_path = home .. "/.local/share/nvim/mason/packages/java-debug-adapter"
local java_test_path = home .. "/.local/share/nvim/mason/packages/java-test"

-- Find the Java executable
local function get_java_executable()
    -- Check JAVA_HOME first
    local java_home = os.getenv("JAVA_HOME")
    if java_home and vim.fn.executable(java_home .. "/bin/java") == 1 then
        return java_home .. "/bin/java"
    end
    -- Check if java is in PATH
    if vim.fn.executable("java") == 1 then
        return "java"
    end
    -- Fallback to known locations
    local known_paths = {
        home .. "/.config/Code/User/globalStorage/pleiades.java-extension-pack-jdk/java/latest/bin/java",
        "/usr/lib/jvm/java-21-openjdk/bin/java",
        "/usr/lib/jvm/java-17-openjdk/bin/java",
    }
    for _, path in ipairs(known_paths) do
        if vim.fn.executable(path) == 1 then
            return path
        end
    end
    vim.notify("Could not find Java executable!", vim.log.levels.ERROR)
    return "java"
end

-- Determine OS for launcher config
local function get_os_config()
    local os_name = vim.fn.has("mac") == 1 and "mac"
        or vim.fn.has("unix") == 1 and "linux"
        or "win"
    return os_name
end

-- Find root directory
local root_markers = { "pom.xml", "build.gradle", "gradlew", ".git", "mvnw", "settings.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if not root_dir then
    -- Fallback: use the directory containing the current file
    root_dir = vim.fn.expand("%:p:h")
end

-- Workspace directory (unique per project)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, "p")

-- Build the launcher jar path
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "/config_" .. get_os_config()

-- Debug bundles
local bundles = {}

-- Add java-debug-adapter
local java_debug_bundle = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if java_debug_bundle ~= "" then
    table.insert(bundles, java_debug_bundle)
end

-- Add java-test
local java_test_bundles = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n")
for _, bundle in ipairs(java_test_bundles) do
    if bundle ~= "" and not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar") then
        table.insert(bundles, bundle)
    end
end

-- Capabilities from nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Extended client capabilities for nvim-jdtls
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Main JDTLS configuration
local config = {
    cmd = {
        get_java_executable(),
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx2g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", config_path,
        "-data", workspace_dir,
    },

    root_dir = root_dir,
    capabilities = capabilities,

    settings = {
        java = {
            home = os.getenv("JAVA_HOME"),
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            references = { includeDecompiledSources = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            format = { enabled = true },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                    "org.mockito.Mockito.*",
                    "org.mockito.ArgumentMatchers.*",
                    "org.mockito.Answers.*",
                    "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                    "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
                    "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "jakarta",
                    "org",
                    "com",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        },
    },

    init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    },

    on_attach = function(client, bufnr)
        -- Enable jdtls commands
        jdtls.setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()

        -- Buffer-local keymaps for Java
        local opts = { buffer = bufnr, silent = true }
        local map = vim.keymap.set

        -- Standard LSP keymaps (same as your plugin/lsp.lua)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "go", vim.lsp.buf.type_definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gs", vim.lsp.buf.signature_help, opts)
        map("n", "gl", vim.diagnostic.open_float, opts)
        map("n", "<F2>", vim.lsp.buf.rename, opts)
        map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
        map("n", "<F4>", vim.lsp.buf.code_action, opts)

        -- Java-specific keymaps
        map("n", "<leader>jo", jdtls.organize_imports, { buffer = bufnr, desc = "Organize Imports" })
        map("n", "<leader>jv", jdtls.extract_variable, { buffer = bufnr, desc = "Extract Variable" })
        map("v", "<leader>jv", function() jdtls.extract_variable(true) end, { buffer = bufnr, desc = "Extract Variable" })
        map("n", "<leader>jc", jdtls.extract_constant, { buffer = bufnr, desc = "Extract Constant" })
        map("v", "<leader>jc", function() jdtls.extract_constant(true) end, { buffer = bufnr, desc = "Extract Constant" })
        map("v", "<leader>jm", function() jdtls.extract_method(true) end, { buffer = bufnr, desc = "Extract Method" })
        map("n", "<leader>jt", jdtls.test_nearest_method, { buffer = bufnr, desc = "Test Nearest Method" })
        map("n", "<leader>jT", jdtls.test_class, { buffer = bufnr, desc = "Test Class" })
        map("n", "<leader>ju", jdtls.update_project_config, { buffer = bufnr, desc = "Update Project Config" })

        vim.notify("JDTLS attached to " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
    end,
}

-- Start or attach JDTLS
jdtls.start_or_attach(config)
