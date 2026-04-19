```bash
#!/bin/bash

echo "🚀 Iniciando configuração do Antigravity Local Offload..."

# 1. Verifica se o Ollama está instalado
if ! command -v ollama &> /dev/null
then
    echo "❌ Erro: Ollama não encontrado. Instale-o primeiro acessando https://ollama.com/"
    exit 1
fi

# 2. Verifica se o Node.js está instalado
if ! command -v node &> /dev/null
then
    echo "❌ Erro: Node.js não encontrado. Instale o Node.js (recomendado via NVM)."
    exit 1
fi

echo "📦 Baixando o modelo qwen2.5-coder:7b-instruct via Ollama..."
ollama pull qwen2.5-coder:7b-instruct

echo "⚙️  Criando script wrapper para o MCP..."

# Descobre o diretório binário atual do Node/NVM dinamicamente
NODE_BIN_DIR=$(dirname $(which node))
WRAPPER_PATH="$HOME/start-ollama-mcp.sh"

# Cria o script wrapper injetando o PATH dinâmico
cat <<EOF > $WRAPPER_PATH
#!/bin/bash
# Script gerado automaticamente pelo setup.sh
export PATH="$NODE_BIN_DIR:\$PATH"
npx -y ollama-mcp-server
EOF

# Dá permissão de execução ao wrapper
chmod +x $WRAPPER_PATH

echo "✅ Setup concluído com sucesso!"
echo "----------------------------------------------------"
echo "O script wrapper foi criado em: $WRAPPER_PATH"
echo "Por favor, siga as instruções no README.md para configurar a interface do Antigravity."

```
