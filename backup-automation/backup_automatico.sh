#!/bin/bash

# 1. Variáveis
ORIGEM="/home/ubuntu/meus_dados"
DESTINO="/home/ubuntu/servidor_backup"
LOG="$DESTINO/backup.log"
DATA_AGORA=$(date "+%Y-%m-%d %H:%M:%S")

# 2. Criar as pastas (Garante que o erro anterior não volte)
mkdir -p "$DESTINO/snapshots"
mkdir -p "$DESTINO/atual"

# 3. Início do Log
echo "------------------------------------------" >> "$LOG"
echo "INÍCIO DO BACKUP: $DATA_AGORA" >> "$LOG"

# 4. Verificação de Segurança
if [ ! -d "$ORIGEM" ]; then
    echo "ERRO: Pasta de origem não encontrada!" >> "$LOG"
    exit 1
fi

# 5. Execução (Rsync e Tar)
echo "Sincronizando arquivos..." >> "$LOG"
rsync -av --delete "$ORIGEM/" "$DESTINO/atual/" >> "$LOG" 2>&1

echo "Compactando..." >> "$LOG"
tar -cvzf "$DESTINO/snapshots/backup_$(date +%Y%m%d_%H%M).tar.gz" -C "$DESTINO/atual" . >> "$LOG" 2>&1

# Limpeza: Apaga arquivos de backup (.tar.gz) com mais de 7 dias de idade
find /home/ubuntu/servidor_backup/ -name "*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

echo "FIM DO BACKUP: $(date "+%Y-%m-%d %H:%M:%S")" >> "$LOG"
