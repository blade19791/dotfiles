return {
	-- Mason setup
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"cssls",
					"jdtls",
					"ts_ls",
					"intelephense",
					"pyright",
					"clangd",
					"emmet_ls",
					"lua_ls",
				},
			})
		end,
	},

	-- LSP configuration (modern, lazy-loaded)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
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

			-- Server definitions
			local servers = {
				lua_ls = {
					filetypes = { "lua" },
					on_attach = on_attach,
					capabilities = capabilities,
					root_dir = function(fname)
						local util = require("lspconfig.util")
						return util.find_git_ancestor(fname)
							or util.root_pattern("init.lua", "lua")(fname)
							or vim.fn.getcwd()
					end,
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
					},
				},
				html = { filetypes = { "html" }, on_attach = on_attach, capabilities = capabilities },
				cssls = { filetypes = { "css", "scss", "less" }, on_attach = on_attach, capabilities = capabilities },
				ts_ls = {
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
					on_attach = on_attach,
					capabilities = capabilities,
				},
				intelephense = { filetypes = { "php" }, on_attach = on_attach, capabilities = capabilities },
				pyright = { filetypes = { "python" }, on_attach = on_attach, capabilities = capabilities },
				clangd = {
					filetypes = { "c", "cpp", "objc", "objcpp" },
					on_attach = on_attach,
					capabilities = capabilities,
				},
				emmet_ls = {
					filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
					on_attach = on_attach,
					capabilities = capabilities,
				},
			}

			-- Lazy-load LSPs per filetype
			for name, config in pairs(servers) do
				vim.api.nvim_create_autocmd("FileType", {
					pattern = config.filetypes,
					callback = function()
						vim.lsp.config(name, config)
						-- Removed vim.lsp.start(...) — not needed
					end,
				})
			end

			-- Java setup (nvim-jdtls)
			local function setup_jdtls()
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
					settings = {
						java = {
							configuration = {
								runtimes = {
									{ name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
									{ name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk" },
									{ name = "JavaSE-1.8", path = "/usr/lib/jvm/java-8-openjdk" },
								},
							},
						},
					},
					on_attach = on_attach,
					capabilities = capabilities,
				}
				require("jdtls").start_or_attach(config)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = setup_jdtls,
			})
		end,
	},

	-- Java extension
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
}
