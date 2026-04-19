# Google Antigravity: Local LLM Offload via MCP
Este projeto permite configurar o Google Antigravity IDE para delegar tarefas pesadas de codificação para um modelo local (Ollama) utilizando o protocolo MCP.
Utilizando o padrão arquitetural **Orchestrator-Worker**, transformamos os modelos em nuvem do Antigravity (ex: Gemini Flash) em orquestradores de baixo custo. Eles roteiam instruções para o seu hardware local (ex: qwen2.5-coder) via MCP.
**Vantagens:** Privacidade absoluta do código gerado localmente, latência reduzida (usando sua GPU local) e economia massiva de tokens da cota de nuvem.
## 🛠️ Pré-requisitos
 * Ollama instalado no sistema.
 * Node.js e npm/npx instalados (recomendado via NVM).
 * Google Antigravity IDE.
## 🚀 Passo 1: Instalação Automatizada
Clone este repositório e execute o script de setup. Ele fará o download do modelo otimizado e criará dinamicamente o script de inicialização do MCP (start-ollama-mcp.sh) resolvendo o caminho do seu ambiente Node.
```bash
chmod +x setup.sh
./setup.sh

```
*(Opcional: Certifique-se de que o serviço do Ollama está rodando em background com ollama serve)*
## ⚙️ Passo 2: Configuração Manual no Antigravity
Para que os agentes de nuvem enxerguem sua máquina como uma "Tool", registre o servidor MCP na interface da IDE:
 1. No Antigravity, pressione Ctrl + , para abrir as **Settings**.
 2. Navegue até a aba **Customizations** no menu lateral esquerdo.
 3. Clique no botão **Open MCP Config** no canto superior direito.
 4. Adicione a configuração JSON abaixo. **Substitua SEU_USUARIO pelo seu usuário do sistema:**
```json
{
  "mcpServers": {
    "ollama-worker": {
      "command": "/home/SEU_USUARIO/start-ollama-mcp.sh",
      "args": [],
      "env": {
        "OLLAMA_HOST": "[http://127.0.0.1:11434](http://127.0.0.1:11434)"
      }
    }
  }
}

```
 5. Salve o arquivo e clique em **Refresh**. O status do ollama-worker deve ficar azul/ativo.
## 🧠 Passo 3: Utilizando a Skill de Offload
A skill de roteamento já está incluída na pasta .agents/skills/offload.md deste repositório.
Para utilizá-la, abra o painel de agentes, selecione um modelo rápido (como o **Gemini 3 Flash**) e digite seu prompt instruindo o uso da skill.
**Exemplo de Prompt:**
> "Analise o arquivo services/auth_service.dart. Eu preciso implementar um rate limiter. Em vez de você escrever o código, use a **skill offload** para delegar essa tarefa ao modelo local. Pegue a resposta dele e aplique no arquivo."
> 
O Gemini fará o planejamento, sua máquina fará a codificação bruta, e o arquivo será atualizado de forma autônoma.
