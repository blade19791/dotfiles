-- return {
-- 	{
-- 		"shaunsingh/nord.nvim",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			-- Set theme
-- 			vim.cmd([[colorscheme nord]])
--
-- 			-- Optional: Better syntax highlighting
-- 			vim.g.nord_italic = true
-- 			vim.g.nord_italic_comments = true
-- 			vim.g.nord_uniform_status_lines = true
--
-- 			-- Transparent background (if you want)
-- 			-- vim.g.nord_disable_background = true
-- 		end,
-- 	},
-- }

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}

-- nordic theme

-- -- nordic theme
-- return {
-- 	{
-- 		"AlexvZyl/nordic.nvim",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			local nordic = require("nordic")
--
-- 			nordic.setup({
-- 				transparent = {
-- 					bg = true, -- make main background transparent
-- 					float = true, -- make floating windows (like Telescope) transparent
-- 				},
-- 				override = {
-- 					-- Visual mode background
-- 					Visual = { bg = "#3B4252" },
-- 				},
-- 			})
--
-- 			nordic.load()
--
-- 			-- 🧭 Telescope custom styling
-- 			local accent = "#A2BD8B" -- nord green (use "#A5926C" for yellow)
-- 			local hl = vim.api.nvim_set_hl
--
-- 			-- Borders
-- 			hl(0, "TelescopeBorder", { fg = accent, bg = "none" })
-- 			hl(0, "TelescopePromptBorder", { fg = accent, bg = "none" })
-- 			hl(0, "TelescopeResultsBorder", { fg = accent, bg = "none" })
-- 			hl(0, "TelescopePreviewBorder", { fg = accent, bg = "none" })
--
-- 			-- Titles
-- 			hl(0, "TelescopeTitle", { fg = accent, bold = true, bg = "none" })
-- 			hl(0, "TelescopePromptTitle", { fg = accent, bold = true, bg = "none" })
-- 			hl(0, "TelescopeResultsTitle", { fg = accent, bold = true, bg = "none" })
-- 			hl(0, "TelescopePreviewTitle", { fg = accent, bold = true, bg = "none" })
--
-- 			-- Backgrounds (transparent)
-- 			hl(0, "TelescopeNormal", { bg = "none" })
-- 			hl(0, "TelescopePromptNormal", { bg = "none" })
-- 			hl(0, "TelescopeResultsNormal", { bg = "none" })
-- 			hl(0, "TelescopePreviewNormal", { bg = "none" })
--
-- 			-- Prompt area and prefix
-- 			hl(0, "TelescopePromptPrefix", { fg = accent, bg = "none" })
--
-- 			-- Optional: Selection highlight (soft nord blue-gray)
-- 			hl(0, "TelescopeSelection", { bg = "#434C5E", fg = "#ECEFF4" })
-- 		end,
-- 	},
-- }
