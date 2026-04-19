## name: offload
description: Skill para economizar tokens delegando tarefas de codificação ao modelo local qwen2.5-coder:7b-instruct via Ollama.
# Skill: Token Offload (Qwen Worker)
Esta skill permite que tarefas de codificação repetitivas ou que demandam muito contexto sejam processadas localmente, reduzindo o consumo de tokens do modelo principal (Gemini).
## Objetivo
Delegar a geração ou refatoração de código para o modelo qwen2.5-coder:7b-instruct rodando via Ollama e aplicar as mudanças localmente.
## Fluxo de Trabalho
 1. **Preparação do Contexto**:
   * Identifique o arquivo alvo e a tarefa específica (ex: adicionar um método, refatorar um widget).
   * Prepare um prompt claro que inclua o código necessário e as instruções.
 2. **Execução via Ollama**:
   * Use a ferramenta mcp_ollama-worker_run (disponível via MCP) com os seguintes parâmetros:
     * name: qwen2.5-coder:7b-instruct
     * prompt: Seu prompt de codificação detalhado.
 3. **Processamento da Resposta**:
   * Extraia o código retornado pelo Qwen da resposta do MCP.
   * Valide se o código está completo e correto, sem omitir partes importantes.
 4. **Aplicação Local**:
   * Utilize as ferramentas nativas de edição de arquivo (como replace_file_content ou multi_replace_file_content) para atualizar o arquivo local com o novo código processado pela sua máquina.
## Exemplo de Uso (Pseudo-comando)
"Antigravity, use a skill offload para implementar a lógica de validação no arquivo user_service.dart usando o Qwen local."
## Notas de Segurança
 * Certifique-se de que o Ollama está rodando na porta 11434 e o modelo qwen2.5-coder:7b-instruct está instalado.
 * O Agente sempre deve revisar o código gerado pelo modelo local antes de aplicar a modificação no disco.
