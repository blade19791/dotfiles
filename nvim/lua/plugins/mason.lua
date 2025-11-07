return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"flake8",
					"eslint_d",
					"prettier",
					"stylua",
					"black",
					"phpcsfixer",
					"phpcs",
					"clang-format",
				},
			})
		end,
	}, -- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local mason_lsp = require("mason-lspconfig")

			mason_lsp.setup({
				ensure_installed = {
					"html",
					"cssls",
					"ts_ls",
					"pyright",
					"clangd",
					"lua_ls",
					"emmet_ls",
					"intelephense",
					"jdtls",
				},
			})
		end,
	}, -- Core LSP plugin
	{ "neovim/nvim-lspconfig" }, -- Java Extension
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
}