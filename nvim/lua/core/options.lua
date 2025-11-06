vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader = " "
-- vim.opt.clipboard = "unnamedplus"
vim.cmd("set clipboard+=unnamedplus")       -- Use system clipboard
vim.cmd("set mouse=a")                      -- Enable mouse support
vim.cmd("set wrap")                         -- Enable line wrapping
vim.cmd("set linebreak")                    -- Wrap lines at convenient points
vim.cmd("set ignorecase")                   -- Case insensitive searching
vim.cmd("set smartcase")                    -- Case sensitive if uppercase letter is used
vim.cmd("set incsearch")                    -- Incremental search
vim.cmd("set hlsearch")                     -- Highlight search results
vim.cmd("set scrolloff=8")                  -- Keep 8 lines visible when scrolling
vim.cmd("set sidescrolloff=8")              -- Keep 8 columns visible when side-scrolling
vim.cmd("set signcolumn=yes")               -- Always show the sign column
vim.cmd("set splitright")                   -- Vertical splits open to the right
vim.cmd("set splitbelow")                   -- Horizontal splits open below
vim.cmd("set termguicolors")                -- Enable true color support
vim.cmd("set updatetime=300")               -- Faster completion
vim.cmd("set timeoutlen=500")               -- Time to wait for a mapped sequence to complete
vim.cmd("set completeopt=menuone,noselect") -- Better completion experience
vim.cmd("set undofile")                     -- Enable persistent undo

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
