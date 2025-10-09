return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = true,
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

			-- -- Use setup_handlers to automatically call vim.lsp.config
			-- mason_lsp.setup_handlers({
			-- 	function(server_name)
			-- 		local ok, _ = pcall(require, "lsp." .. server_name)
			-- 		if not ok then
			-- 			vim.notify(
			-- 				"No dedicated LSP config for " .. server_name .. ", using default.",
			-- 				vim.log.levels.INFO
			-- 			)
			-- 			vim.lsp.config[server_name].setup({})
			-- 		end
			-- 	end,
			-- })
		end,
	}, -- Core LSP plugin
	{ "neovim/nvim-lspconfig" }, -- Java Extension
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	}, -- null-ls (for formatters and linters)
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = { -- Formatters
					null_ls.builtins.formatting.black, -- Python
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.clang_format, -- C/C++
					null_ls.builtins.formatting.phpcsfixer, -- PHP
					null_ls.builtins.formatting.prettier.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"css",
							"html",
							"json",
						},
					}), -- Linters and code actions
					null_ls.builtins.diagnostics.flake8,
					null_ls.builtins.diagnostics.phpcs,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.code_actions.eslint_d,
				},

				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
								})
								vim.lsp.buf.code_action({
									filter = function(a)
										return a.data
											and a.data._null_ls
											and a.data._null_ls.code_action_kind == "source.fixAll.eslint"
									end,
									apply = true,
								})
							end,
						})
					end

					vim.keymap.set("n", "<leader>gf", function()
						vim.lsp.buf.format()
						vim.lsp.buf.code_action({
							filter = function(a)
								return a.data
									and a.data._null_ls
									and a.data._null_ls.code_action_kind == "source.fixAll.eslint"
							end,
							apply = true,
						})
					end, {
						buffer = bufnr,
						desc = "Format + ESLint fix",
					})
				end,
			})
		end,
	},
}
