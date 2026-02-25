# 🛡️ Estratégia de Backup Local e Gestão de Ciclo de Vida (Retention)

## 📋 Descrição do Projeto
Solução automatizada em Bash Script para backup incremental e compactado, implementando uma política de retenção de dados (Lifecycle Management) para otimização de armazenamento em servidores Linux.

## 🛠️ Tecnologias Utilizadas
* **Rsync**: Sincronização incremental inteligente.
* **Tar (Gzip)**: Compactação de dados para redução de custos de armazenamento.
* **Cron**: Automação de tarefas agendadas (Scheduled Tasks).
* **Bash Script**: Lógica de automação e tratamento de logs.
* **Find**: Implementação da regra de expurgo (Retenção de 7 dias).

## ⚙️ Como o Sistema Funciona
1. **Sincronização**: O script espelha os arquivos da origem para uma área de staging.
2. **Compactação**: Gera um arquivo `.tar.gz` nomeado com o timestamp da execução.
3. **Logs**: Cada etapa é registrada em um arquivo `.log` para auditoria.
4. **Limpeza Automática**: Arquivos de backup com mais de 7 dias são deletados automaticamente para preservar o espaço em disco.

## 🚀 Como Configurar
1. Clone este repositório.
2. Ajuste as variáveis de caminho no script `backup_automatico.sh`.
3. Adicione ao Crontab (`crontab -e`):
   `15 03 * * * /bin/bash /caminho/do/script.sh`
