local cmd = vim.cmd
local indent = 2

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.node_host_prog = "/Users/folke/.pnpm-global/4/node_modules/neovim/bin/cli.js"

vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = indent -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically

vim.o.tabstop = indent -- Number of spaces tabs count for
vim.o.updatetime = 200 -- save swap file and trigger CursorHold
vim.o.mouse = "a" -- enable mouse mode
vim.o.hidden = true -- Enable modified buffers in background
vim.o.ignorecase = true -- Ignore case
vim.o.joinspaces = false -- No double spaces with join after a dot
vim.o.scrolloff = 4 -- Lines of context
vim.o.shiftround = true -- Round indent
vim.o.sidescrolloff = 8 -- Columns of context
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitright = true -- Put new windows right of current
vim.o.termguicolors = true -- True color support
vim.o.wildmode = "list:longest" -- Command-line completion mode
vim.o.guifont = "FiraCode Nerd Font:h12"
vim.o.clipboard = "unnamedplus" -- sync with system clipboard

vim.wo.list = true -- Show some invisible characters (tabs...
vim.wo.number = true -- Print line number
vim.wo.relativenumber = true -- Relative line numbers
vim.wo.wrap = false -- Disable line wrap
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.wo.conceallevel = 2 -- Hide * markup for bold and italic
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 6

cmd("syntax enable")
cmd("filetype plugin indent on")
-- Highlight on yank
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}")