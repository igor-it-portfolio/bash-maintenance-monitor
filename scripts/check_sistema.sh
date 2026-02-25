#!/bin/bash
###############################################################################
# NOME DO SCRIPT: check_sistema.sh (Integrado ao Automation Kit)
# DESCRIÇÃO: Gera relatório de saúde usando configurações globais.
###############################################################################

# 1. IMPORTANDO CONFIGURAÇÕES (A Mágica do Projeto)
# O comando 'source' lê as variáveis do settings.conf como se estivessem aqui
source /home/ubuntu/Linux-System-Admin/config/settings.conf

# 2. VARIÁVEIS LOCAIS
DATA_HORA=$(date "+%Y-%m-%d %H:%M:%S")

# 3. FUNÇÕES MELHORADAS
# O 'tee -a' escreve no terminal e no arquivo de log definido no settings.conf
log_msg() {
    echo "[$DATA_HORA] $1" | tee -a "$ARQUIVO_LOG"
}

# --- INÍCIO DA EXECUÇÃO ---
echo "----------------------------------------------------" | tee -a "$ARQUIVO_LOG"
log_msg "Iniciando verificação de rotina (Framework Mode)..."

# 1. ANÁLISE DE ARMAZENAMENTO
# Note que agora usamos $LIMITE_DISCO que vem lá do settings.conf
uso_atual=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')

if [ "$uso_atual" -gt "$LIMITE_DISCO" ]; then
    log_msg "[ALERTA] Uso de disco crítico: ${uso_atual}% (Limite: ${LIMITE_DISCO}%)"
else
    log_msg "[OK] Disco operando em níveis normais: ${uso_atual}%"
fi

# 2. VERIFICAÇÃO DE REDE
# Note que agora usamos $URL_TESTE_REDE do settings.conf
ping -c 1 "$URL_TESTE_REDE" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    log_msg "[OK] Conectividade com $URL_TESTE_REDE confirmada."
else
    log_msg "[ERRO] Servidor sem acesso a $URL_TESTE_REDE!"
fi

log_msg "Monitoramento finalizado."
echo "----------------------------------------------------" | tee -a "$ARQUIVO_LOG"
