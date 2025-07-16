local M = {}

-- Função para compilar arquivo baseado na extensão
function M.compile_file()
    -- Salvar o arquivo antes de compilar
    vim.cmd('w')
    
    local filename = vim.fn.expand('%')
    local extension = vim.fn.fnamemodify(filename, ':e')
    local basename = vim.fn.fnamemodify(filename, ':r')
    
    local commands = {
        c = 'gcc ' .. filename .. ' -o ' .. basename .. ' && echo "C compilado com sucesso!"',
        cpp = 'g++ ' .. filename .. ' -o ' .. basename .. ' && echo "C++ compilado com sucesso!"',
        java = 'javac ' .. filename .. ' && echo "Java compilado com sucesso!"',
        py = 'echo "Python não precisa compilar"',
        js = 'echo "JavaScript não precisa compilar"',
        ts = 'npx tsc ' .. filename .. ' && echo "TypeScript compilado com sucesso!"',
        go = 'go build ' .. filename .. ' && echo "Go compilado com sucesso!"',
        rs = 'rustc ' .. filename .. ' && echo "Rust compilado com sucesso!"',
        php = 'echo "PHP não precisa compilar"',
        rb = 'echo "Ruby não precisa compilar"',
        lua = 'echo "Lua não precisa compilar"',
    }
    
    local command = commands[extension] or 'echo "Extensão não suportada: ' .. extension .. '"'
    local result = vim.fn.system(command)
    vim.api.nvim_echo({{result, 'Normal'}}, true, {})
end

-- Função para executar arquivo baseado na extensão
function M.run_file()
    -- Salvar o arquivo antes de executar
    vim.cmd('w')
    
    local filename = vim.fn.expand('%')
    local extension = vim.fn.fnamemodify(filename, ':e')
    local basename = vim.fn.fnamemodify(filename, ':r')
    
    local commands = {
        c = './' .. basename,
        cpp = './' .. basename,
        java = function()
            -- Verificar se é um projeto Maven
            if vim.fn.filereadable('pom.xml') == 1 then
                -- Tentar encontrar a classe principal automaticamente
                local main_class = vim.fn.system('find src -name "*.java" -exec grep -l "public static void main" {} \\; | head -1 | sed "s|src/main/java/||" | sed "s|.java||" | sed "s|/|.|g"')
                main_class = vim.fn.trim(main_class)
                
                if main_class ~= '' then
                    return 'mvn exec:java -Dexec.mainClass="' .. main_class .. '"'
                else
                    return 'echo "Classe principal não encontrada. Use: mvn exec:java -Dexec.mainClass=com.exemplo.MainClass"'
                end
            else
                return 'java ' .. basename
            end
        end,
        py = 'python3 ' .. filename,
        js = 'node ' .. filename,
        ts = 'node ' .. basename .. '.js',
        go = './' .. basename,
        rs = './' .. basename,
        php = 'php ' .. filename,
        rb = 'ruby ' .. filename,
        lua = 'lua ' .. filename,
    }
    
    local command = commands[extension]
    if type(command) == 'function' then
        command = command()
    end
    command = command or 'echo "Extensão não suportada: ' .. extension .. '"'
    
    local result = vim.fn.system(command)
    vim.api.nvim_echo({{result, 'Normal'}}, true, {})
end

return M 