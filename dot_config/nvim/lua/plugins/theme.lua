return {
  -- Install without configuration
  { "projekt0n/github-nvim-theme", name = "github-theme" },

  -- Or with configuration
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark")
    end,
  },

  -- {
  --   "nvim-mini/mini.base16",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --   end
  -- },

  { "xiyaowong/transparent.nvim" },
}
