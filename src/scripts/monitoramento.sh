#!/usr/bin/env bash

LOCKFILE="/tmp/monitorar.lock"
LOGS="/var/log/monitorar.log"
BOT_TOKEN="[COLE AQUI O TOKEN GERADO PELO BOT]"
CHAT_ID="[COLE SEU CHAT_ID]"

exec 200>"$LOCKFILE"
if ! flock -n 200; then
    echo "O script já está em execução. Abortando."
    exit 1
fi

trap 'rm -f "$LOCKFILE"' EXIT

touch "$LOCKFILE"

if [ ! -f "$LOGS" ]; then
    touch "$LOGS"
fi

enviar_alerta() {
    local MENSAGEM="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$MENSAGEM" > /dev/null 2>&1
}

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
TIME=$(date "+%d-%m-%Y %H:%M:%S")

case $STATUS in
    200)
        echo "$TIME - ✅ Site online!" >> "$LOGS"
        ;;
    400)
        MENSAGEM="$TIME - 🚨 ERRO 400: Requisição inválida!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    401)
        MENSAGEM="$TIME - 🚨 ERRO 401: Não autorizado!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    403)
        MENSAGEM="$TIME - 🚨 ERRO 403: Acesso proibido!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    404)
        MENSAGEM="$TIME - 🚨 ERRO 404: Página não encontrada!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    408)
        MENSAGEM="$TIME - 🚨 ERRO 408: Tempo limite da requisição!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    429)
        MENSAGEM="$TIME - 🚨 ERRO 429: Muitas requisições!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    500)
        MENSAGEM="$TIME - 🚨 ERRO 500: Erro interno do servidor!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    502)
        MENSAGEM="$TIME - 🚨 ERRO 502: Gateway inválido!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    503)
        MENSAGEM="$TIME - 🚨 ERRO 503: Serviço indisponível!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    504)
        MENSAGEM="$TIME - 🚨 ERRO 504: Tempo limite do gateway!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    *)
        MENSAGEM="$TIME - 🚨 ERRO $STATUS: Servidor offline!"
        echo "$MENSAGEM" >> "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
esac

rm -f "$LOCKFILE"