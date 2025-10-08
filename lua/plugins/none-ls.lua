return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- Formatters
					null_ls.builtins.formatting.black, -- Python
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.clang_format, -- C/C++
					-- null_ls.builtins.formatting.google - java - format, -- java
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
					}),

					-- Linters
					null_ls.builtins.diagnostics.flake8, -- Python
					null_ls.builtins.diagnostics.phpcs, -- PHP
					null_ls.builtins.diagnostics.eslint_d,

					-- ESLint code actions
					null_ls.builtins.code_actions.eslint_d,
				},

				-- Auto format + ESLint fix on save
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								-- First run formatters (Prettier, Black, Stylua, etc.)
								vim.lsp.buf.format({ bufnr = bufnr })

								-- Then run ESLint auto-fix
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
				end,
			})

			-- Manual format + ESLint fix
			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format()
				vim.lsp.buf.code_action({
					filter = function(a)
						return a.data and a.data._null_ls and a.data._null_ls.code_action_kind == "source.fixAll.eslint"
					end,
					apply = true,
				})
			end, { desc = "Format + ESLint fix" })
		end,
	},
}
