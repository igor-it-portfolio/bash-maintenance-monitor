#!/bin/bash
###############################################################################
# NOME DO SCRIPT: auditoria.sh
# DESCRIÇÃO: Valida a integridade do Framework e permissões.
###############################################################################

# 1. TENTATIVA DE IMPORTAR CONFIGURAÇÕES
CONFIG_FILE="/home/ubuntu/Linux-System-Admin/config/settings.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "[ERRO CRÍTICO] Arquivo de configuração não encontrado em $CONFIG_FILE"
    exit 1
fi

DATA_HORA=$(date "+%Y-%m-%d %H:%M:%S")
log_msg() {
    echo "[$DATA_HORA] [AUDITORIA] $1" | tee -a "$ARQUIVO_LOG"
}

# --- INÍCIO DA EXECUÇÃO ---
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" | tee -a "$ARQUIVO_LOG"
log_msg "Iniciando Auditoria de Integridade do Sistema..."

# 2. VERIFICANDO DIRETÓRIOS CRÍTICOS
for pasta in "$DIR_LOGS" "$DIR_BACKUPS" "$DIR_PROJETO/scripts"; do
    if [ -d "$pasta" ]; then
        log_msg "[OK] Diretório verificado: $pasta"
    else
        log_msg "[FALHA] Diretório ausente: $pasta"
    fi
done

# 3. VERIFICANDO PERMISSÕES DE EXECUÇÃO NOS SCRIPTS
log_msg "Verificando permissões dos scripts..."
for script in "$DIR_PROJETO/scripts"/*.sh; do
    if [ -x "$script" ]; then
        log_msg "[OK] Execução permitida: $(basename "$script")"
    else
        log_msg "[AVISO] Sem permissão de execução: $(basename "$script")"
    fi
done

log_msg "Auditoria finalizada."
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" | tee -a "$ARQUIVO_LOG"
