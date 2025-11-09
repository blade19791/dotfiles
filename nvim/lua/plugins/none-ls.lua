return {
	"nvimtools/none-ls.nvim",
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local null_ls = require("null-ls")

		local sources = {
			-- Lua
			null_ls.builtins.formatting.stylua,

			-- Python
			null_ls.builtins.formatting.black,
			null_ls.builtins.diagnostics.flake8,

			-- JavaScript / JSX / TypeScript
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"json",
					"html",
					"css",
				},
			}),
			null_ls.builtins.diagnostics.eslint_d,

			-- PHP
			null_ls.builtins.formatting.phpcsfixer,
			null_ls.builtins.diagnostics.phpcs,

			-- C / C++
			null_ls.builtins.formatting.clang_format,
		}

		null_ls.setup({
			sources = sources,
			debug = true,

			on_attach = function(client, bufnr)
				-- Disable other LSPs formatting (like tsserver/ts_ls)
				client.server_capabilities.documentFormattingProvider = true

				-- Autoformat on save
				if client.supports_method("textDocument/formatting") then
					local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							print("[none-ls] formatting before save...")
							vim.lsp.buf.format({ async = false })
						end,
					})
				end

				-- Manual format <leader>gf
				vim.keymap.set("n", "<leader>gf", function()
					print("[none-ls] formatting manually...")
					vim.lsp.buf.format({ async = true })
				end, { buffer = bufnr, desc = "Format file with LSP/None-ls" })
			end,
		})
	end,
}
