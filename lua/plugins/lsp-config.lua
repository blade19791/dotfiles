return {
	-- Mason setup
	{
		"williamboman/mason.nvim",
		config = true,
	},
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

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- LSP keymaps
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				-- Diagnostics
				vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { buffer = bufnr })
				vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = bufnr })
				vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = bufnr })
				vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr })

				-- Format on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end

			local lspconfig = require("lspconfig")

			-- Safe root_dir helper to avoid Neo-tree errors
			local function safe_root_dir(fname, patterns)
				if type(fname) ~= "string" then
					return vim.loop.cwd()
				end
				local util = require("lspconfig.util")
				return util.find_git_ancestor(fname)
					or (patterns and util.root_pattern(unpack(patterns))(fname))
					or vim.loop.cwd()
			end

			-- Auto-register Mason-installed servers
			for _, server in ipairs(mason_lsp.get_installed_servers()) do
				local ok, cfg = pcall(require, "lspconfig.server_configurations." .. server)
				local filetypes = ok and cfg.filetypes or { server }

				vim.api.nvim_create_autocmd("FileType", {
					pattern = filetypes,
					callback = function()
						-- Special settings for lua_ls
						local settings = nil
						local root = nil
						if server == "lua_ls" then
							root = safe_root_dir(vim.api.nvim_buf_get_name(0), { "init.lua", "lua" })
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = {
										checkThirdParty = false,
										library = vim.api.nvim_get_runtime_file("", true),
									},
									telemetry = { enable = false },
								},
							}
						end

						lspconfig[server].setup({
							on_attach = on_attach,
							capabilities = capabilities,
							filetypes = filetypes,
							root_dir = root or safe_root_dir,
							settings = settings,
						})
					end,
				})
			end

			-- Java setup (nvim-jdtls)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
					local config = {
						cmd = {
							"java",
							"-Declipse.application=org.eclipse.jdt.ls.core.id1",
							"-Dosgi.bundles.defaultStartLevel=4",
							"-Declipse.product=org.eclipse.jdt.ls.core.product",
							"-Dlog.protocol=true",
							"-Dlog.level=ALL",
							"-Xms1g",
							"--add-modules=ALL-SYSTEM",
							"--add-opens",
							"java.base/java.util=ALL-UNNAMED",
							"--add-opens",
							"java.base/java.lang=ALL-UNNAMED",
							"-jar",
							vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
							"-configuration",
							jdtls_path .. "/config_linux",
							"-data",
							vim.fn.stdpath("cache") .. "/jdtls-workspace",
						},
						root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
						on_attach = on_attach,
						capabilities = capabilities,
					}
					require("jdtls").start_or_attach(config)
				end,
			})
		end,
	},

	-- Java extension
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
}
