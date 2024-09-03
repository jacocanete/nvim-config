-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- tabs and indentation
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard = "unnamedplus"
