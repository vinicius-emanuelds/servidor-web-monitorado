# **MONITORANDO UM SERVIDOR WEB**

## **Visão Geral**
Este projeto tem como objetivo configurar um servidor web na AWS com monitoramento automático. Ele inclui:
- Criação de uma **VPC** com sub-redes públicas e privadas.
- Configuração de uma **instância EC2** e instalação do **Nginx**.
- Criação de uma **página HTML** para testes.
- Implementação de um **script de monitoramento** com envio de notificação para o **Telegram.
- Opção de **automatização** com **User Data** e **CloudFormation**.

---

## Preparação
Antes de iniciarmos as configurações do ambiente AWS e a criação do servidor, é preciso configurar nosso setup para que este se conecte com a instância AWS. Ainda, precisamos configurar todo o processo de webhook com o Telegram.

### Configurando o AWS CLI
  Basicamente, iremos nos conectar à instância através do terminal, via linha de comando. Para isto, iremos configurar o **AWS CLI** em nosso setup. [Clique aqui](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) para acessar a documentação oficial, com um passo a passo detalhado para a instalação e configuração.

### Configurando o Webhook no Telegram
#### **Passo 1: Criar o Bot**
1. No Telegram, procure por `@BotFather`.
2. Inicie uma conversa e envie o comando `/newbot`.
3. O BotFather pedirá um nome para o bot (exemplo: `MonitoramentoBot`).
4. Em seguida, pedirá um nome de usuário único, que deve terminar com "bot" (exemplo: `MonitoramentoServer_bot`).
5. Após a criação, o BotFather fornecerá um **Token de API**, que será necessário para enviar mensagens. **Guarde esse token**.

#### **Passo 2: Obter o Chat ID**
Para enviar mensagens, precisamos saber para onde o bot deve enviá-las.
1. Acesse `https://t.me/RawDataBot` no Telegram e inicie uma conversa.
2. Ele fornecerá seu `chat_id`. **Guarde essa informação**

#### **Passo 3: Iniciar o Bot**
Para enviar mensagens através do webhook, precisamos "iniciar" nosso bot para que ele reconheça nosso chat_id.
1. No Telegram, procure por `@MonitoramentoBot` (use o nome que você deu ao bot.
2. Inicie uma conversa enviando o comando `/start.

---

## **Etapa 1: Configuração do Ambiente**

### **1. Criar a VPC**
Agora vamos criar uma VPC na AWS com 4 sub-redes (2 privadas e 2 públicas), com um internet gateway conectado à uma das sub-redes públicas.

- Após logar no console AWS, selecione VPC (ou digite na barra de busca).
![1 Dashboard.png](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/1%20Dashboard.png)

- Clique em *Create VPC*
![2 VPC.png](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/2%20VPC.png)

- Aplique as configurações abaixo e clique em *Create VPC*
![2.1 VPC.png](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/2.1%20VPC.png)
![2.2 VPC.png](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/2.2%20VPC.png)
- Se as configurações estiverem corretas, o fluxo ser similar à esse:
![<2.3 VPC.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/2.3%20VPC.png)

### Criando um Security Group
- No dashboard, clique em EC2. Depois, na seção à esquerda, selecione *Secuity Group*
![<3 SG.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/3%20SG.png)

- Clique em *Create Security Group*
![<3.1 SG.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/3.1%20SG.png)

- Aplique as configurações abaixo e clique em *Create Security Group*
![<3.2 SG.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/3.2%20SG.png))
![<3.3 SG.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/3.3%20SG.png)

### **Criar a instância EC2**
- Em EC2, na seção à esquerda, clique em *Instances* e depois em "Launch Instances"
![<4 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4%20EC2.png)
![<4.0 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.0%20EC2.png)

- Aplique as configurações abaixo:
![<4.1 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.1%20EC2.png)
![<4.2 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.2%20EC2.png)

- Para criar um "Key Pair", faça:
![<4.3 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.3%20EC2.png)

- Após a criação, a chave será baixada automaticamente para sua máquina. É importante mantê-la disponível no momento da conexão com a instância. Se estiver usando o windows, com wsl, utilize o comando abaixo para copiar para a máquina Linux. Se já estiver utilizando Linux, pule esta etapa.
```cmd
scp \caminho_para_chave\[SUA_CHAVE].pem [USUÁRIO]@[IP_LINUX]:/home/[USUÁRIO]
```

- Já no linux, aplique as permissões para a chave:
```bash
chmod 400 [SUA_CHAVE].pem
```

- Continue as configurações:
![<4.4 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.4%20EC2.png)
![<4.5 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.5%20EC2.png)

- Revise as configurações e clique em *Launch Instance*
![<4.6 EC2.png>](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/4.6%20EC2.png)

## **Etapa 2: Conectando-se à Instância**
Agora é o momento de testar se todas as configurações foram aplicadas corretamente.

- No seu terminal linux, utilize o comando abaixo:
```bash
ssh -i /local/da/chave/privada/[SUA_CHAVE].pem [USUÁRIO_EC2]@ip_publico
```
- Será solicitado a confirmação de acesso. Digite `yes` e aperte enter. Se tudo ocorrer como esperado, você estará conectado à instância EC2

## **Etapa 3: Configuração do Servidor Web**
### **1 - Instalar o e iniciar o Nginx**
No seu terminal, digite os seguintes comandos:
```bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### **2 - Criar a Página HTML**
Agora, vamos usar o editor Nano para criar a página HTML exibida ao acessar o servidor. Digite no terminal:

```bash
sudo nano /var/www/html/index.html
```

Adicione o conteúdo de sua página ao editor. Abaixo, temos um exemplo de página básica:
```html
<!DOCTYPE html>
<html>
<head><title>Servidor Web</title></head>
<body>
    <h1>Servidor Web configurado!</h1>
</body>
</html>
```
Para salvar as alterações do Nano, digte `Ctrl + x`, `y` e aperte `enter`.

### **3 - Testar o Servidor**
Agora, acesse um navegador e coloque o IP público da instância. Se tudo estiver configurado corretamente, você deverá visualizar a página.

---

## **Etapa 4: Monitoramento e Notificações**
### **1 - Criar o Script de Monitoramento**
Agora, vamos configurar o monitoramento do servidor através de um shell script.

No terminal, digite:
```bash
sudo nano /home/[USUÁRIO]/monitoramento.sh
```

Adicione no editor:
```bash
#!/usr/bin/env bash

LOCKFILE="/tmp/monitorar.lock"
LOGS="/var/log/monitorar.log"
BOT_TOKEN="[COLE AQUI O TOKEN GERADO PELO BOT]"
CHAT_ID="[COLE SEU CHAT_ID]"

if [ -e "$LOCKFILE" ]; then
    echo "O script já está em execução. Abortando."
    exit 1
fi

trap 'rm -f "$LOCKFILE"' EXIT

touch "$LOCKFILE"

if [ ! -f "$LOGS" ]; then
    mkdir -p $(dirname "$LOGS")
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
        echo "$TIME - ✅ Site online!" | tee -a "$LOGS"
        ;;
    400)
        MENSAGEM="$TIME - 🚨 ERRO 400: Requisição inválida!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    401)
        MENSAGEM="$TIME - 🚨 ERRO 401: Não autorizado!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    403)
        MENSAGEM="$TIME - 🚨 ERRO 403: Acesso proibido!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    404)
        MENSAGEM="$TIME - 🚨 ERRO 404: Página não encontrada!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    408)
        MENSAGEM="$TIME - 🚨 ERRO 408: Tempo limite da requisição!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    429)
        MENSAGEM="$TIME - 🚨 ERRO 429: Muitas requisições!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    500)
        MENSAGEM="$TIME - 🚨 ERRO 500: Erro interno do servidor!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    502)
        MENSAGEM="$TIME - 🚨 ERRO 502: Gateway inválido!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    503)
        MENSAGEM="$TIME - 🚨 ERRO 503: Serviço indisponível!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    504)
        MENSAGEM="$TIME - 🚨 ERRO 504: Tempo limite do gateway!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
    *)
        MENSAGEM="$TIME - 🚨 ERRO $STATUS: Problema desconhecido!"
        echo "$MENSAGEM" | tee -a "$LOGS"
        enviar_alerta "$MENSAGEM"
        ;;
esac

rm -f "$LOCKFILE"
```

Agora, iremos alterar as permissões do arquivo para que ele possa ser executado:
```bash
sudo chmod +x /home/[USUÁRIO]/monitoramento.sh
```

### **2 - Automatizar a Execução com Cron**
Agora vamos automatizar a execução do script com o Cron.
No terminal, digite:
```bash
sudo crontab -e
```
Escolha uma das 4 opções de editor. Depois, adicione ao final do arquivo:
```bash
*/1 * * * * /home/ubuntu/monitorar.sh
```
Salve o arquivo. Dessa forma, o script irá verificar, a cada minuto, se o servidor está online. Caso ele esteja offline, uma notificação será encaminhado ao Telegram.

---

## **Etapa 4: Testes**

### **1️⃣ Testar a Implementação**
- Acesse `http://IP_DA_INSTANCIA` para verificar o site.

- Pare o Nginx e aguarde 1 minuto:
  ```bash
  sudo systemctl stop nginx
  ```

- Verifique os logs:
  ```bash
  tail -f /var/log/monitoramento.log
  ```

- Confirme no Telegram o recebimento das notificações.

- Reinicie o Nginx:
  ```bash
  sudo systemctl start nginx
  ```
<br>
Você também pode automatizar o teste criando um script. Para isso, no terminal, digite:

```bash
sudo nano /home/[USUÁRIO]/nginx_status.sh
```

Adicione no editor:
```bash
#!/usr/bin/env bash

# Verifica o status do serviço nginx
STATUS=$(systemctl is-active nginx)

if [ "$STATUS" == "active" ]; then
    # Se o nginx está ativo, então desativa
    echo "O serviço nginx está ativo. Desativando..."
    sudo systemctl stop nginx
else
    # Se o nginx está inativo, então ativa
    echo "O serviço nginx está inativo. Ativando..."
    sudo systemctl start nginx
fi
```

Altere as permissões do arquivo para que ele possa ser executado:
```bash
sudo chmod +x /home/[USUÁRIO]/nginx_status.sh
```

Vamos automatizar a execução:
```bash
sudo crontab -e
```

Adicione ao final do arquivo:
```bash
*/3 * * * * /home/ubuntu/nginx_status.sh
```
Salve o arquivo. Dessa forma, o script irá verificar, a cada 3 minutos, se o nginx está ativo. Caso ele esteja inativo, ele irá ativar. Se ele estiver ativo, ele irá desativar.

Para parar a execução, edite o arquivo cron e exclua a linha referente ao script.
---



## **Automatização com User Data**
Uma outra forma de fazer as configurações da instância é a utilização de *User Data* no momento da criação da instância.
Para isso, siga a [Etapa 1](#etapa-1-configuração-do-ambiente), mas, antes de lançar a instância, faça a seguinte configuração:

- Expanda as configurações avançadas:
![5 USERDATA.png](https://github.com/vinicius-emanuelds/servidor-web-monitorado/blob/316fdcc66d7d88ac2ee91acc2ac84cabaf2f06fe/src/assets/to_README/5%20USERDATA.png)
Adicione este script no campo **"User Data"** ao criar a EC2:
```bash
#!/bin/bash
apt update -y && apt upgrade -y
apt install -y nginx
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html><body><h1>Servidor via User Data</h1></body></html>
EOF
systemctl restart nginx
systemctl enable nginx
```

### **2️⃣ Infraestrutura com CloudFormation**
Crie um arquivo `infraestrutura.yaml`:
```yaml
AWSTemplateFormatVersion: "2010-09-09"
Description: "Provisiona uma VPC, sub-redes, EC2 e configura o servidor."
Resources:
  MinhaVPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: "10.0.0.0/16"
  SubnetPublica:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref MinhaVPC
      CidrBlock: "10.0.1.0/24"
      MapPublicIpOnLaunch: true
  MinhaEC2:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: "t2.micro"
      ImageId: "ami-0c55b159cbfafe1f0"
      SubnetId: !Ref SubnetPublica
      UserData:
        Fn::Base64: |
          #!/bin/bash
          apt update -y
          apt install -y nginx
          echo "<h1>Servidor via CloudFormation!</h1>" > /var/www/html/index.html
```

---

## **🎯 Conclusão**
Agora você tem um **servidor web totalmente configurado e monitorado**, com opções de **automatização** para facilitar a implantação.

**Diferenciais deste projeto:**
✔ Configuração manual e automatizada com **User Data**.
✔ Infraestrutura como código com **CloudFormation**.
✔ Monitoramento inteligente com **notificações automáticas**.

🚀 **Agora é sua vez de testar e personalizar!**

