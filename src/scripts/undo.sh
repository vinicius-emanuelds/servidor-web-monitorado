#!/usr/bin/env bash

# Script de Reversão
# Remove todas as configurações e arquivos criados pelo script original

# 1. Para e remove o serviço Nginx
sudo systemctl stop nginx
sudo systemctl disable nginx
sudo apt purge nginx nginx-common -y
sudo apt autoremove -y

# 2. Remove os arquivos do site
sudo rm -rf /var/www/html/index.html
sudo rm -rf /var/www/html/css
sudo rm -rf /var/www/html/js

# 3. Remove os scripts de monitoramento
rm -f /home/usuario/monitorar.sh
rm -f /home/usuario/nginx_status.sh

# 4. Remove os arquivos de lock
sudo rm -f /tmp/monitorar.lock

# 5. Remove os logs e diretório de monitoramento
sudo rm -rf /var/log/monitoramento

# 6. Remove as entradas do crontab
crontab -l | grep -v "monitorar.sh" | grep -v "nginx_status.sh" | crontab -

# 7. Remove pacotes não utilizados
sudo apt autoclean