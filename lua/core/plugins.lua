local plugins = {
  -- LSP e Autocomplete
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('core.lsp_config')
    end,
  },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_lua').lazy_load({ paths = { vim.fn.stdpath('config') .. '/lua/snippets' } })
    end,
  },
  { 'rafamadriz/friendly-snippets' },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1000,
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'black' },
          go = { 'gofmt' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          json = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          java = { 'google-java-format' },
          markdown = { 'prettier' },
          yaml = { 'prettier' },
          sh = { 'shfmt' },
        },
      })
      vim.api.nvim_set_keymap('n', '<leader>F', ":lua require('conform').format({async = true, lsp_fallback = true})<CR>", { noremap = true, silent = true })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.prettier,
        },
      })
    end,
  },

  -- Test runner
  {
    'vim-test/vim-test',
    config = function()
      vim.g['test#strategy'] = 'neovim'
      vim.api.nvim_set_keymap('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tF', ':TestFile<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tV', ':TestVisit<CR>', { noremap = true, silent = true })
    end,
  },

  -- Árvore de arquivos
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = { width = 35, side = 'left' },
        renderer = { icons = { show = { file = true, folder = true, folder_arrow = true, git = true } } },
        filters = { dotfiles = false },
        git = { enable = true },
        actions = { open_file = { quit_on_open = false } },
      }
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>fe', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
    end,
  },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },
  { 'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed', 'RainbowDelimiterYellow', 'RainbowDelimiterBlue',
          'RainbowDelimiterOrange', 'RainbowDelimiterGreen', 'RainbowDelimiterViolet', 'RainbowDelimiterCyan',
        },
      }
    end,
  },

  -- UI e Temas
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          section_separators = '',
          component_separators = '',
        }
      }
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
      -- Configurar linhas do cursor após o tema
      vim.cmd('set cursorline')
      vim.cmd('set cursorcolumn')
      vim.cmd('highlight CursorLine guibg=#3a3a3a ctermbg=238')
      vim.cmd('highlight CursorColumn guibg=#2e2e2e ctermbg=237')
    end,
  },
  { 'folke/tokyonight.nvim', priority = 1000 },
  { 'sainnhe/sonokai' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({ '*'; }, { names = false })
    end,
  },

  -- Fuzzy Finder
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 20,
        open_mapping = [[<c-\>]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        direction = 'float',
        float_opts = { border = 'curved' },
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      }
      -- Atalhos para diferentes layouts
      vim.api.nvim_set_keymap('n', '<leader>tt', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tg', ":lua require('toggleterm.terminal').Terminal:new({cmd='lazygit', direction='float'}):toggle()<CR>", { noremap = true, silent = true })
    end,
  },

  -- Git
  { 'lewis6991/gitsigns.nvim' },
  { 'sindrets/diffview.nvim' },

  -- Utilidades
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
      require('which-key').register({
        ['<leader>f'] = { name = '+Telescope' },
        ['<leader>t'] = { name = '+Testes' },
        ['<leader>ff'] = { 'Find Files' },
        ['<leader>fg'] = { 'Live Grep' },
        ['<leader>fb'] = { 'Buffers' },
        ['<leader>fh'] = { 'Help Tags' },
        ['<leader>e'] = { 'Toggle File Tree' },
        ['<leader>fe'] = { 'Find File in Tree' },
        ['<leader>F'] = { 'Format Buffer' },
        ['<leader>oi'] = { 'Organizar Imports (Java)' },
        ['<leader>il'] = { 'Importar Lombok' },
        ['<leader>ut'] = { 'Alternar Tema' },
        ['<F5>'] = { 'Compilar Java' },
        ['<F6>'] = { 'Executar Java' },
        ['<F7>'] = { 'Compilar Arquivo' },
        ['<F8>'] = { 'Executar Arquivo' },
        ['<leader>tn'] = { 'Test Nearest (vim-test)' },
        ['<leader>tF'] = { 'Test File (vim-test)' },
        ['<leader>ts'] = { 'Test Suite/Summary' },
        ['<leader>tl'] = { 'Test Last (vim-test)' },
        ['<leader>tV'] = { 'Test Visit (vim-test)' },
        ['<leader>tr'] = { 'Run Test (neotest)' },
        ['<leader>td'] = { 'Debug Test (neotest)' },
        ['<leader>to'] = { 'Test Output (neotest)' },
        ['<leader>tt'] = { 'Terminal Horizontal' },
        ['<leader>tv'] = { 'Terminal Vertical' },
        ['<leader>tf'] = { 'Terminal Flutuante' },
        ['<leader>tg'] = { 'Lazygit Terminal' },
        ['<leader>mp'] = { 'Markdown Preview' },
        ['<leader>y'] = { 'Duplicar Linha/Bloco' },
        ['<A-j>'] = { 'Mover Linha/Bloco para Baixo' },
        ['<A-k>'] = { 'Mover Linha/Bloco para Cima' },
        ['<C-n>'] = { 'Multi-cursor (visual-multi)' },
        ['ys'] = { 'Add Surround' },
        ['cs'] = { 'Change Surround' },
        ['ds'] = { 'Delete Surround' },
        ['<leader>mm'] = { 'Minimap Toggle' },
        ['<leader>ma'] = { 'Toggle Bookmark' },
        ['<leader>mn'] = { 'Next Bookmark' },
        ['<leader>bp'] = { 'Prev Bookmark' },
        ['<leader>ml'] = { 'List Bookmarks (Telescope)' },
        ['<leader>ss'] = { 'Salvar Sessão' },
        ['<leader>sr'] = { 'Restaurar Sessão' },
        ['<leader>sd'] = { 'Deletar Sessão' },
        ['<leader>sl'] = { 'Listar Sessões (Telescope)' },
        ['<C-h>'] = { 'Buffer Esquerda' },
        ['<C-l>'] = { 'Buffer Direita' },
        ['<C-j>'] = { 'Buffer Baixo' },
        ['<C-k>'] = { 'Buffer Cima' },
        ['th'] = { 'Split Horizontal' },
        ['tv'] = { 'Split Vertical' },
        ['tt'] = { 'Fechar Buffer' },
        ['tr'] = { 'Buffer Anterior' },
        ['ty'] = { 'Próximo Buffer' },
      }, { mode = 'n' })
    end,
  },
  { 'numToStr/Comment.nvim' },
  { 'windwp/nvim-autopairs' },

  -- Debug
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },

  -- Project
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        detection_methods = { 'lsp', 'pattern' },
        patterns = { 'pom.xml', '.git', 'build.gradle', 'Makefile' },
      }
    end,
  },
  -- Docker, YAML, Markdown
  { 'b0o/schemastore.nvim' },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = { 'markdown' },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })
    end,
  },
  -- Produtividade
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'mg979/vim-visual-multi' },
  { 'matze/vim-move' },
  -- Dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },
  -- Minimap
  {
    'wfxr/minimap.vim',
    build = 'cargo install --locked code-minimap',
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 0
      vim.g.minimap_auto_start_win_enter = 0
      vim.api.nvim_set_keymap('n', '<leader>mm', ':MinimapToggle<CR>', { noremap = true, silent = true })
    end,
  },
  -- Bookmarks
  { 'MattesGroeger/vim-bookmarks' },
  {
    'tom-anders/telescope-vim-bookmarks.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'MattesGroeger/vim-bookmarks' },
    config = function()
      require('telescope').load_extension('vim_bookmarks')
      vim.api.nvim_set_keymap('n', '<leader>ma', ':BookmarkToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>mn', ':BookmarkNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>bp', ':BookmarkPrev<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ml', ':Telescope vim_bookmarks all<CR>', { noremap = true, silent = true })
    end,
  },
  -- Session management
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
      }
      vim.api.nvim_set_keymap('n', '<leader>ss', ':SessionSave<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>sr', ':SessionRestore<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>sd', ':SessionDelete<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({})
      vim.api.nvim_set_keymap('n', '<leader>sl', ':Telescope session-lens search_session<CR>', { noremap = true, silent = true })
    end,
  },
}

return { spec = plugins } 