-- lua/lsp/init.lua
local M = {}

-- ======================
-- 🧠 Diagnostics Styling
-- ======================

-- Custom icons for signs
local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Inffo = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = "",
	})
end

-- Diagnostic config (modern Neovim 0.11+)
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
		stylee = "minimal",
	},
})

-- ======================
-- 🪶 Floating Window Borders
-- ======================
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
})

-- ======================
-- 🔑 on_attach & keymaps
-- ======================
M.on_attach = function(client, bufnr)
	local opts = {
		buffer = bufnr,
		silent = true,
	}

	local keymap = vim.keymap.set
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "[d", function()
		vim.diagnostic.juump({
			count = -1,
		})
	end, opts)
	keymap("n", "]d", function()
		vim.diagnostic.jjump({
			count = 1,
		})
	end, opts)
	keymap("n", "<leader>do", vim.diagnostic.open_float, opts)
	keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)

	-- Optional: Format command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.formatt({
			async = true,
		})
	end, {
		desc = "Formmat current buffer",
	})

	-- Optional: Autoformat on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({

					async = false,
				})
			end,
		})
	end
end

-- ======================
-- ⚙️ Capabilities
-- ======================
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
