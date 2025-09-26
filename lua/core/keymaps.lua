-- WINDOW NAVIGATION
vim.keymap.set("n", "<C-l>", "<C-w>l", {
	desc = "Move to right window",
})
vim.keymap.set("n", "<C-h>", "<C-w>h", {
	desc = "Move to left window",
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
	desc = "Move to up window",
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
	desc = "Move to down window",
})

-- INSERT MODE EXIT
vim.keymap.set("i", "jk", "<Esc>", {
	desc = "Exit insert mode",
})
vim.keymap.set("i", "kj", "<Esc>", {
	desc = "Exit insert mode",
})

-- COPILOT
-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<Tab>")', { silent = true, expr = true }) -- Accept suggestion
-- vim.api.nvim_set_keymap("i", "<C-]>", "<Plug>(copilot-next)", {}) -- Next suggestion
-- vim.api.nvim_set_keymap("i", "<C-[>", "<Plug>(copilot-previous)", {}) -- Previous suggestion
-- vim.api.nvim_set_keymap("i", "<C-\\>", "<Plug>(copilot-suggest)", {}) -- Trigger suggestion
-- vim.api.nvim_set_keymap("i", "<C-e>", "<Plug>(copilot-dismiss)", {}) -- Dismiss suggestion
-- vim.keymap.set('n', '<leader>cp', ':Copilot toggle<CR>', { desc = 'Toggle Copilot' })

-- QUALITY OF LIFE
-- Save and quit
vim.keymap.set("n", "<leader>w", ":w<CR>", {
	desc = "Save file",
})
vim.keymap.set("n", "<leader>q", ":q<CR>", {
	desc = "Quit window",
})
vim.keymap.set("n", "<leader>Q", ":q!<CR>", {
	desc = "Force quit",
})

-- Buffer navigation
vim.keymap.set("n", "<S-l>", ":bnext<CR>", {
	desc = "Next buffer",
})
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", {
	desc = "Previous buffer",
})
vim.keymap.set("n", "<leader>bb", ":bdelete<CR>", { desc = "Close current buffer" })

-- Clear search highlight
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", {
	desc = "Clear search highlights",
})

-- Better indent in visual mode
vim.keymap.set("v", "<", "<gv", {
	desc = "Indent left and keep selection",
})
vim.keymap.set("v", ">", ">gv", {
	desc = "Indent right and keep selection",
})

-- Close current buffer
vim.keymap.set("n", "<leader>c", ":bd<CR>", {
	desc = "Close buffer",
})

-- Move lines up/down in normal & visual mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", {
	desc = "Move line down",
})
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {
	desc = "Move line up",
})
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", {
	desc = "Move selection down",
})
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", {
	desc = "Move selection up",
})

-- Keep cursor centered when jumping
vim.keymap.set("n", "n", "nzzzv", {
	desc = "Next search result centered",
})
vim.keymap.set("n", "N", "Nzzzv", {
	desc = "Prev search result centered",
})
vim.keymap.set("n", "J", "mzJ`z", {
	desc = "Join lines and keep cursor",
})

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opt)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- terminal shortcut
-- Open a terminal in a new horizontal split with <leader>t
-- vim.keymap.set('n', '<leader>T', ':split | terminal<CR>', opts)

-- Open a terminal in a new vertical split with <leader>T
-- vim.keymap.set('n', '<leader>t', ':vsplit | terminal<CR>', opts)

-- Open a terminal in the current window with <F5>

-- Alternative: Open terminal in a horizontal split with <C-t>
-- vim.keymap.set('n', '<C-t>', ':split | terminal<CR>', opts)

local terminal_buf = nil

local function toggle_terminal()
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		-- If terminal buffer exists and is valid, delete it
		vim.cmd("bdelete! " .. terminal_buf)
		terminal_buf = nil
	else
		-- Open a new terminal in a horizontal split and store its buffer ID
		vim.cmd("split | terminal")
		terminal_buf = vim.api.nvim_get_current_buf()
	end
end

vim.keymap.set("n", "<leader>t", toggle_terminal, opts)

-- Exit terminal mode with jk
vim.api.nvim_set_keymap("t", "jk", "<C-\\><C-n>", {
	noremap = true,
	silent = true,
})

-- Reload Neovim config without restarting
vim.keymap.set("n", "<leader>cr", function()
	for name, _ in pairs(package.loaded) do
		if name:match("^user") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.fn.stdpath("config") .. "/init.lua")
	print("Config reloaded!")
end, {
	desc = "Reload Neovim config",
})

-- Toggle next theme
vim.keymap.set("n", "<leader>tt", function()
	require("core.themes").next()
end, { desc = "Toggle themes" })

-- Pick theme via Telescope
vim.keymap.set("n", "<leader>ft", function()
	require("core.themes").pick()
end, { desc = "Pick theme (Telescope)" })
