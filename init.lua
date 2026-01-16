-- Set JAVA_HOME if not already set (for GUI Neovim instances)
if not vim.env.JAVA_HOME then
    local java_path = vim.fn.expand("~/.config/Code/User/globalStorage/pleiades.java-extension-pack-jdk/java/latest")
    if vim.fn.isdirectory(java_path) == 1 then
        vim.env.JAVA_HOME = java_path
    end
end

require('config.options')
require('config.keybinds')
require('config.lazy')
