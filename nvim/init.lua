-- Ensure syntax highlighting is enabled
vim.cmd("syntax on")

-- Enable true colors for better colorscheme support
vim.opt.termguicolors = true

-- Add Mason bin to PATH so null-ls/none-ls can find executables
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not string.find(vim.env.PATH, mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

--[[ this reloads all snippets form ~/.config/nvim/snippets
instead of write this command ":lua require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })]]
vim.api.nvim_create_user_command("ReloadSnippets", function()
    require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/snippets"
    })
    print("LuaSnip snippets reloaded ✅")
end, {})

-- Bootstrap lazy.nvim, LazyVim and your plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable releas
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("core/options") -- set options / import options.lua
require("core/keymaps") -- set keymaps
require("lsp.init") -- import lsp config

require("lazy").setup("plugins")
