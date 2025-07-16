-- Carregamento do gerenciador de plugins (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Carregar plugins com lazy.nvim
require('lazy').setup(require('core.plugins').spec)

require "core.keymaps"
require "core.options"
require "core.ui" 