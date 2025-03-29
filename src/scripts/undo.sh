#!/usr/bin/env bash

# Script de Reversão
# Remove todas as configurações e arquivos criados pelo script original

# Para e remove o serviço Nginx
sudo systemctl stop nginx
sudo systemctl disable nginx
sudo apt purge nginx nginx-common -y
sudo apt autoremove -y

# Remove os arquivos do site
sudo rm -rf /var/www/html/index.html
sudo rm -rf /var/www/html/css
sudo rm -rf /var/www/html/js

# Remove os scripts de monitoramento
rm -f /home/usuario/monitorar.sh
rm -f /home/usuario/nginx_status.sh

# Remove os arquivos de lock
sudo rm -f /tmp/monitorar.lock

# Remove os logs e diretório de monitoramento
sudo rm -rf /var/log/monitoramento

# Remove as entradas do crontab
crontab -l | grep -v "monitorar.sh" | grep -v "nginx_status.sh" | crontab -

# Remove pacotes não utilizados
sudo apt autoclean