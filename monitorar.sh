#!/usr/bin/env bash

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
# curl: ferramenta para transferência de dados com URL
# -s: evita saídas desnecessárias
# -o /dev/null: não exibe o conteúdo da página
# -w "%{http_code}": exibe apenas o código de status da requisição
#   código 200: sucesso
#   código 404: página não encontrada
#   código 500: erro interno do servidor

while true; do
    if [ $STATUS -ne 200 ]; then
        echo "Site fora do ar! STATUS: $STATUS"
    else
        echo "Site online!"
    fi
    sleep 60
done
