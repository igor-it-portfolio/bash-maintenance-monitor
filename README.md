# Bash Automation Kit: Framework de Manutenção e Monitoramento

Um ecossistema modular de scripts Bash projetado para automatizar tarefas críticas de administração de sistemas Linux.

## 🚀 Funcionalidades
- **Monitoramento:** Checagem de saúde de disco e conectividade de rede.
- **Manutenção:** Limpeza automatizada de logs e backups antigos com base em retenção configurável.
- **Auditoria:** Verificação de integridade de diretórios e permissões do sistema.
- **Configuração Centralizada:** Gerenciamento de caminhos e limites via `settings.conf`.

## 📁 Estrutura do Projeto
- `scripts/`: Motores de execução (.sh).
- `config/`: Arquivos de configuração e parâmetros.
- `logs/`: Histórico detalhado de todas as execuções (Auditoria).
- `backups/`: Destino de arquivos organizados.

## 🛠️ Como Usar
1. Configure seus caminhos e limites em `config/settings.conf`.
2. Dê permissão de execução: `chmod +x scripts/*.sh`.
3. Execute a auditoria inicial: `./scripts/auditoria.sh`.
4. Monitore seu sistema: `./scripts/check_sistema.sh`.

---
*Projeto desenvolvido durante a Imersão SysAdmin 2026.*
