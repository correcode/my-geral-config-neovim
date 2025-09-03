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
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "mfussenegger/nvim-jdtls" }, -- LSP específico para Java

    -- Autocomplete
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },

    -- Syntax Highlight + Rainbow Brackets
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "HiPhish/nvim-ts-rainbow2",
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
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copiar para clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Colar do clipboard" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Colar do clipboard" })

-- =========================
-- Configurações Gerais
-- =========================
vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.termguicolors = true

-- =========================
-- Atalhos gerais
-- =========================
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Salvar" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Sair" })

vim.keymap.set("n", "<leader>t", ":split | terminal<CR>", { desc = "Abrir terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do terminal" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Mover para esquerda" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Mover para direita" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Mover para baixo" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Mover para cima" })

vim.keymap.set("n", "tt", ":bd<CR>", { desc = "Fechar buffer atual" })
vim.keymap.set("n", "tr", ":b#<CR>", { desc = "Voltar buffer anterior" })
vim.keymap.set("n", "ty", ":bnext<CR>", { desc = "Próximo buffer" })

vim.keymap.set("n", "op", "m`o<Esc>``", { desc = "Linha abaixo sem mover cursor" })
vim.keymap.set("n", "oi", "m`O<Esc>``", { desc = "Linha acima sem mover cursor" })

vim.keymap.set("n", "th", ":vnew<CR>", { desc = "Novo buffer à direita" })
vim.keymap.set("n", "tv", ":new<CR>", { desc = "Novo buffer abaixo" })

-- =========================
-- Plugins Config
-- =========================
-- Tema escuro
vim.cmd("colorscheme gruvbox")
vim.o.background = "dark"

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

-- =========================
-- Mason + LSP
-- =========================
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "jdtls", "lua_ls" },
})

local lspconfig = require("lspconfig")

-- Configuração base para LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup {
    capabilities = capabilities,
}

-- Java (usando nvim-jdtls)
-- Para projetos Java, iniciar com :Jdtls
local jdtls_ok, jdtls = pcall(require, "jdtls")
if jdtls_ok then
    local root_markers = { "gradlew", "mvnw", ".git" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local home = os.getenv("HOME")

    local jdtls_config = {
        cmd = { "jdtls" },
        root_dir = root_dir,
        capabilities = capabilities,
    }

    if root_dir then
        jdtls.start_or_attach(jdtls_config)
    end
end

-- =========================
-- Autocomplete (nvim-cmp)
-- =========================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})
