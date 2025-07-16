-- Alternar temas rapidamente
vim.api.nvim_set_keymap('n', '<leader>ut', ":lua require('core.ui').toggle_theme()<CR>", { noremap = true, silent = true })

local current_theme = 1
local themes = { 'catppuccin-mocha', 'tokyonight-night', 'sonokai' }
function _G.ToggleTheme()
  current_theme = current_theme % #themes + 1
  vim.cmd('colorscheme ' .. themes[current_theme])
  -- Reaplicar as linhas do cursor após trocar tema
  vim.cmd('set cursorline')
  vim.cmd('set cursorcolumn')
  vim.cmd('highlight CursorLine guibg=#3a3a3a ctermbg=238')
  vim.cmd('highlight CursorColumn guibg=#2e2e2e ctermbg=237')
end

local M = {}
function M.toggle_theme()
  _G.ToggleTheme()
end

return M 