local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    {
      "barrett-ruth/live-server.nvim",
      build = "pnpm add -g live-server",
      cmd = { "LiveServerStart", "LiveServerStop" },
      config = true,
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
    { "justinhj/battery.nvim" },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
      "saxon1964/neovim-tips",
      version = "*", -- Only update on tagged releases
      lazy = false, -- Load on startup (recommended for daily tip feature)
      dependencies = {
        "MunifTanjim/nui.nvim",
        -- OPTIONAL: Choose your preferred markdown renderer (or omit for raw markdown)
        "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
        -- OR: "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
      },
      opts = {
        -- OPTIONAL: Location of user defined tips (default value shown below)
        user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
        -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
        user_tip_prefix = "[User] ",
        -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
        warn_on_conflicts = true,
        -- OPTIONAL: Daily tip mode (default: 1)
        -- 0 = off, 1 = once per day, 2 = every startup
        daily_tip = 1,
        -- OPTIONAL: Bookmark symbol (default: "🌟 ")
        bookmark_symbol = "🌟 ",
      },
      init = function()
        -- OPTIONAL: Change to your liking or drop completely
        -- The plugin does not provide default key mappings, only commands
        local map = vim.keymap.set
        map("n", "<leader>tto", ":NeovimTips<CR>", { desc = "Neovim tips", silent = true })
        map("n", "<leader>tte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", silent = true })
        map("n", "<leader>tta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", silent = true })
        map("n", "<leader>tth", ":help neovim-tips<CR>", { desc = "Neovim tips help", silent = true })
        map("n", "<leader>ttr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", silent = true })
        map("n", "<leader>ttp", ":NeovimTipsPdf<CR>", { desc = "Open Neovim tips PDF", silent = true })
      end,
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- set tabs to 2 spaces
vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

if vim.fn.executable("pwsh") == 1 then
  vim.o.shell = "pwsh"
else
  vim.o.shell = "powershell"
end

-- Setting shell command flags
vim.o.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"

-- Setting shell redirection
vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
vim.o.shellquote = ""
vim.o.shellxquote = ""
