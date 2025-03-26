#!/usr/bin/env bash

# Verifica o status do serviço nginx
STATUS=$(systemctl is-active nginx)
TIME=$(date "+%d-%m-%Y %H:%M:%S")

if [ "$STATUS" == "active" ]; then
    # Se o nginx está ativo, então desativa
    echo "O serviço nginx está ativo. Desativando..."
    sudo systemctl stop nginx
else
    # Se o nginx está inativo, então ativa
    echo "O serviço nginx está inativo. Ativando..."
    sudo systemctl start nginx
fi