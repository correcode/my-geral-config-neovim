local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- F5: Compilar Java
map('n', '<F5>', ':!mvn clean compile<CR>', opts)
-- F6: Executar Java (com detecção automática da classe principal)
map('n', '<F6>', ':lua require("core.compile").run_file()<CR>', opts)
-- F7: Compilar arquivo atual (detecta linguagem automaticamente)
map('n', '<F7>', ':lua require("core.compile").compile_file()<CR>', opts)
-- F8: Executar arquivo atual (detecta linguagem automaticamente)
map('n', '<F8>', ':lua require("core.compile").run_file()<CR>', opts)
-- TAB como ESC
map('i', '<Tab>', '<Esc>', opts)
-- gg para terminal
map('n', 'gg', ':ToggleTerm<CR>', opts)

-- ToggleTerm atalhos
map('n', '<leader>tt', ':ToggleTerm direction=horizontal<CR>', opts)
map('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', opts)
map('n', '<leader>tf', ':ToggleTerm direction=float<CR>', opts)
map('n', '<leader>tg', ":lua require('toggleterm.terminal').Terminal:new({cmd='lazygit', direction='float'}):toggle()<CR>", opts)

-- NvimTree atalhos
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>fe', ':NvimTreeFindFile<CR>', opts)

-- Markdown Preview
map('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', opts)

-- Minimap
map('n', '<leader>mm', ':MinimapToggle<CR>', opts)

-- Bookmarks
map('n', '<leader>ma', ':BookmarkToggle<CR>', opts)
map('n', '<leader>mn', ':BookmarkNext<CR>', opts)
map('n', '<leader>bp', ':BookmarkPrev<CR>', opts)
map('n', '<leader>ml', ':Telescope vim_bookmarks all<CR>', opts)

-- Session management
map('n', '<leader>ss', ':SessionSave<CR>', opts)
map('n', '<leader>sr', ':SessionRestore<CR>', opts)
map('n', '<leader>sd', ':SessionDelete<CR>', opts)
map('n', '<leader>sl', ':Telescope session-lens search_session<CR>', opts)

-- Format manual
map('n', '<leader>F', ":lua require('conform').format({async = true, lsp_fallback = true})<CR>", opts)

-- Organizar imports Java
map('n', '<leader>oi', ':lua vim.lsp.buf.execute_command({command = "java.action.organizeImports"})<CR>', opts)

-- Importar Lombok manualmente
map('n', '<leader>il', ':lua vim.lsp.buf.execute_command({command = "java.action.addToFavorites", arguments = {"lombok.*"}}) or vim.cmd("normal! iimport lombok.*;")<CR>', opts)

-- vim-test atalhos
map('n', '<leader>tn', ':TestNearest<CR>', opts)
map('n', '<leader>tF', ':TestFile<CR>', opts)
map('n', '<leader>ts', ':TestSuite<CR>', opts)
map('n', '<leader>tl', ':TestLast<CR>', opts)
map('n', '<leader>tV', ':TestVisit<CR>', opts)

-- Produtividade
-- Duplicar linha
map('n', '<leader>y', 'yyp', opts)
map('v', '<leader>y', 'y`>p', opts)
-- Mover linha/bloco
map('n', '<A-j>', ':MoveLine(1)<CR>', opts)
map('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
map('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
map('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
-- Multi-cursor (visual-multi): <C-n> no modo normal/visual
-- Surround: use comandos do vim-surround (ex: cs, ds, ys)

-- Telescope atalhos
map('n', '<leader>ff', ":Telescope find_files<CR>", opts)
map('n', '<leader>fg', ":Telescope live_grep<CR>", opts)
map('n', '<leader>fb', ":Telescope buffers<CR>", opts)
map('n', '<leader>fh', ":Telescope help_tags<CR>", opts)

-- Navegação entre abas
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)

-- Criar novos buffers
map('n', 'th', ':split<CR>', opts)
map('n', 'tv', ':vsplit<CR>', opts)
map('n', 'tt', ':close<CR>', opts)

-- Navegar entre arquivos abertos
map('n', 'tr', ':bprevious<CR>', opts)
map('n', 'ty', ':bnext<CR>', opts)

-- which-key integração removida daqui (agora está no plugins.lua)

-- Project.nvim root detection removido daqui (agora está no plugins.lua) 
map('n', 'tc', ':!') 