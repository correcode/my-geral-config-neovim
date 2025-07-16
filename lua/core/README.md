# Estrutura de Configuração Neovim

- `init.lua`: Arquivo principal, carrega o gerenciador de plugins e as configurações centrais.
- `lua/core/plugins.lua`: Lista e configura todos os plugins via lazy.nvim.
- `lua/core/keymaps.lua`: Atalhos personalizados (F5 compila, F6 executa, F7 testa, <leader>ut troca tema, gg terminal, <leader>ff/fg/fb/fh Telescope, integração com which-key e project.nvim).
- `lua/core/options.lua`: Opções básicas do Neovim (linha, indentação, mouse, etc).
- `lua/core/ui.lua`: Temas (catppuccin, tokyonight, sonokai), lualine, colorizer, web-devicons, rainbow-delimiters, troca de tema por atalho.
- `lua/core/lsp.lua`: Configuração de LSP, autocomplete, snippets e integração com linguagens. Lombok baixado automaticamente para Java.

## Dicas
- Para alternar tema: `<leader>ut`
- Para compilar Java: `F5` (Maven), executar: `F6`, testar: `F7`
- Project.nvim detecta raiz por `pom.xml`, `.git`, `build.gradle`, `Makefile`.
- Lombok é baixado automaticamente para integração com jdtls.

Crie outros arquivos em `lua/core/` para separar configurações avançadas conforme necessário. 