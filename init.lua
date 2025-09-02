-- =========================
-- Lazy.nvim plugin manager
-- =========================
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")


require("lazy").setup({

    -- Tema
    { "morhetz/gruvbox" },

    -- Status bar
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Gerenciamento de arquivos
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Busca e navegação
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" } },

    -- Plugins LSP e autocompletar
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },

    -- Syntax Highlight + Rainbow Brackets
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "HiPhish/nvim-ts-rainbow2", -- substitui o p00f/nvim-ts-rainbow (descontinuado)
    },

})

-- =========================
-- Treesitter
-- =========================
require("nvim-treesitter.configs").setup {
    highlight = { enable = true },
    rainbow = {
        enable = true,
        query = 'rainbow-parens',
        strategy = require('ts-rainbow.strategy.global'),
    }
}

-- =========================
-- Telescope
-- =========================
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Buscar arquivos" })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Grep texto" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers abertos" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Ajuda" })

-- =========================
-- Clipboard do sistema
-- =========================
-- Permite copiar e colar usando Ctrl+C e Ctrl+V
vim.opt.clipboard = "unnamedplus"  -- usa o clipboard do sistema

-- Atalhos para copiar e colar no modo normal/visual
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copiar para clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Colar do clipboard" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Colar do clipboard" })


-- =========================
-- Configurações Gerais
-- =========================
-- Mapear o <space> como leader
vim.g.mapleader = " "

-- Numeração de linhas
vim.o.number = true
vim.o.relativenumber = true

-- Melhorar busca
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentação
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Ativar cores verdadeiras
vim.o.termguicolors = true

-- =========================
-- Atalhos gerais
-- =========================
-- Atalhos para salvar e sair
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Salvar" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Sair" })

-- Terminal integrado
vim.keymap.set("n", "<leader>t", ":split | terminal<CR>", { desc = "Abrir terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do terminal" })

-- Navegação entre janelas
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Mover para esquerda" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Mover para direita" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Mover para baixo" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Mover para cima" })

-- Buffers
vim.keymap.set("n", "tt", ":bd<CR>", { desc = "Fechar buffer atual" })
vim.keymap.set("n", "tr", ":b#<CR>", { desc = "Voltar buffer anterior" })
vim.keymap.set("n", "ty", ":bnext<CR>", { desc = "Próximo buffer" })

-- Inserção de linhas sem sair da posição e sem entrar no insert
vim.keymap.set("n", "op", "m`o<Esc>``", { desc = "Linha abaixo sem mover cursor" })
vim.keymap.set("n", "oi", "m`O<Esc>``", { desc = "Linha acima sem mover cursor" })

-- Novo buffer à direita (split vertical)
vim.keymap.set("n", "th", ":vnew<CR>", { desc = "Novo buffer à direita" })
-- Novo buffer abaixo (split horizontal)
vim.keymap.set("n", "tv", ":new<CR>", { desc = "Novo buffer abaixo" })

-- =========================
-- Plugins Config
-- =========================
-- Tema
vim.cmd("colorscheme gruvbox")

-- Lualine
require("lualine").setup()

-- NvimTree
require("nvim-tree").setup({
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
