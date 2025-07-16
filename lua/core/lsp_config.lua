local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    'jdtls', 'pyright', 'ts_ls', 'gopls', 'clangd', 'csharp_ls', 'html', 'cssls', 'jsonls', 'dockerls', 'yamlls', 'marksman'
  }
}

-- Baixar lombok.jar automaticamente se não existir
local lombok_path = vim.fn.stdpath('data') .. '/lombok.jar'
if vim.fn.filereadable(lombok_path) == 0 then
  vim.fn.system({
    'curl',
    '-L',
    '-o', lombok_path,
    'https://projectlombok.org/downloads/lombok.jar'
  })
end

-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

local lspconfig = require('lspconfig')

-- LSP servers
local servers = {
  pyright = {},
  ts_ls = {},
  gopls = {},
  clangd = {},
  csharp_ls = {},
  html = {},
  cssls = {},
  jsonls = {},
  dockerls = {},
  marksman = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = require('schemastore').yaml.schemas(),
        validate = true,
        hover = true,
        completion = true,
      },
    },
  },
}

for server, config in pairs(servers) do
  if lspconfig[server] then
    lspconfig[server].setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = config.settings,
    }
  end
end

-- Java LSP (jdtls) com lombok
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
lspconfig.jdtls.setup {
  cmd = {
    'java',
    '-javaagent:' .. lombok_path,
    '-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration', jdtls_path .. '/config_linux',
    '-data', vim.fn.expand('~/.cache/jdtls-workspace')
  },
  root_dir = require('lspconfig.util').root_pattern('pom.xml', '.git'),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = '/usr/lib/jvm/java-21-openjdk/',
          },
        },
        -- Bibliotecas padrão
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
      completion = {
        favoriteStaticMembers = {
          "jakarta.*", "java.util.*", "java.time.*", "lombok.*"
        },
        importOrder = {
          "java",
          "javax", 
          "jakarta",
          "lombok",
          "org",
          "com"
        },
        autoImport = true,
        enabled = true,
        guessMethodArguments = true,
      },
      contentProvider = { preferred = 'fernflower' },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      format = {
        enabled = true,
      },
      saveActions = {
        organizeImports = true,
      },
      codeGeneration = {
        useBlocks = true,
        generateComments = true,
      },
      signatureHelp = {
        enabled = true,
      },
      inlayHints = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
    },
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  init_options = {
    bundles = {
      vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar')
    }
  }
} 