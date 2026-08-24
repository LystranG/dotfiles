-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local g = vim.g

opt.tabstop = 4
opt.shiftwidth = 4

-- 关闭自动格式化
g.autoformat = false
