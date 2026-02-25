#!/bin/bash
###############################################################################
# NOME DO SCRIPT: manutencao.sh
# DESCRIÇÃO: Limpa logs e organiza a casa usando o arquivo de configuração.
###############################################################################

# 1. IMPORTANDO CONFIGURAÇÕES
source /home/ubuntu/Linux-System-Admin/config/settings.conf

DATA_HORA=$(date "+%Y-%m-%d %H:%M:%S")

log_msg() {
    echo "[$DATA_HORA] [MANUTENÇÃO] $1" | tee -a "$ARQUIVO_LOG"
}

# --- INÍCIO DA EXECUÇÃO ---
echo "====================================================" | tee -a "$ARQUIVO_LOG"
log_msg "Iniciando rotina de limpeza e organização..."

# 2. LIMPEZA DE LOGS ANTIGOS (Baseado no settings.conf)
# Aqui usamos a variável DIAS_RETENCAO que definimos como 7
log_msg "Removendo logs e backups com mais de $DIAS_RETENCAO dias em $DIR_LOGS..."

find "$DIR_LOGS" -name "*.log" -mtime +"$DIAS_RETENCAO" -exec rm -f {} \;
find "$DIR_BACKUPS" -name "*.tar.gz" -mtime +"$DIAS_RETENCAO" -exec rm -f {} \;

# 3. VERIFICAÇÃO DE TAMANHO DO LOG ATUAL
tamanho_log=$(du -sh "$ARQUIVO_LOG" | awk '{print $1}')
log_msg "Tamanho atual do arquivo de log principal: $tamanho_log"

log_msg "Manutenção finalizada com sucesso."
echo "====================================================" | tee -a "$ARQUIVO_LOG"
