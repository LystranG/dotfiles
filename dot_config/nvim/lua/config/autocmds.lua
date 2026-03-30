-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local colors_path = vim.fn.stdpath("config") .. "/lua/config/matugen.lua"
pcall(dofile, colors_path)
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    -- A. 重新加载颜色文件
    -- 使用 dofile 而不是 require，因为 require 会缓存，无法读取文件的新变化
    dofile(colors_path)
    -- B. 重载 Lualine (LazyVim 默认状态栏)
    -- 颜色变了，状态栏的主题通常也需要刷新才能匹配新颜色
    if package.loaded["lualine"] then
      require("lualine").setup()
    end
    
    -- C. 可选：重载 Bufferline 或其他受颜色影响的插件
    -- vim.cmd("Redraw!") -- 强制重绘界面
    
    print("Matugen colors reloaded!")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "java",
    "c",
    "cpp",
    "h",
    "hpp",
  },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})
