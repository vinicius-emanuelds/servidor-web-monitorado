# COMANDOS MAIS UTILIZADOS

<br>

## Shebang e operadores
`#!/usr/bin/env bash`

Define que o script deve ser interpretado pelo Bash.


<br>

`&&`

Operador lógico E: executa o segundo comando apenas se o primeiro for bem-sucedido.

<br>

## Gerenciamento de pacotes
`sudo apt update -y`

Atualiza a lista de pacotes disponíveis no sistema.

<br>

`sudo apt install [SERVIÇO] -y`

Instala um serviço/pacote específico sem pedir confirmação.

<br>

## Manipulação de arquivos e diretórios
`sudo cat << 'EOF' > /caminho/do/arquivo`

Redireciona um bloco de texto delimitado por EOF para um arquivo.

<br>

`EOF`

Indica o fim da entrada de texto para o redirecionamento.

<br>

`sudo mkdir -p /caminho/do/arquivo`

Cria um diretório e seus diretórios ancestrais, se não existirem.

<br>

## Gerenciamento de serviços
`sudo systemctl enable [SERVIÇO] --now`

Habilita o serviço para iniciar automaticamente e o inicia imediatamente.

<br>

## Declaração de variáveis
`VARIAVEL="/caminho/do/arquivo"`

Define uma variável com o caminho do arquivo.

<br>

## Verificação e criação de arquivos
`if [ ! -f "$VARIAVEL" ]; then`

Verifica se o arquivo não existe.

<br>

`sudo touch "$VARIAVEL"`

Cria um arquivo vazio.

<br>

`sudo chmod 666 "$VARIAVEL"`

Define permissões de leitura e escrita para todos os usuários.

<br>

## Controle de concorrência
`exec 200>"$VARIAVEL"`

Abre o arquivo para escrita e associa o descritor de arquivo 200.

<br>

`if ! flock -n 200; then`

Usa flock (file lock) para garantir que apenas um processo possa acessar o arquivo ao mesmo tempo.

<br>

`echo "[TEXTO]"`

Exibe uma mensagem caso o arquivo já esteja bloqueado.

<br>

`exit 1`

Sai do script com erro.

<br>

## Remoção de arquivos ao sair
`trap 'rm -f "$VARIAVEL"' EXIT`

Garante que o arquivo será removido ao encerrar o script.

<br>

## Função para envio de alertas
`funcao() { ... }`

Declara uma função que envia uma mensagem via curl.

<br>

`curl -s -X POST "[URL]" \ -d "[PARÂMETRO]" -d "text=$MENSAGEM" > /dev/null 2>&1`

Faz uma requisição POST silenciosa para uma URL.

<br>

## Monitoramento de status do servidor
`STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)`

Obtém o código HTTP da resposta do servidor local.

<br>

`TIME=$(date "+%d-%m-%Y %H:%M:%S")`

Captura a data e hora atuais.

<br>

## Tratamento de status HTTP
`case $STATUS in`

Estrutura condicional para diferentes códigos de status.

<br>

`x)`

Se o status for x, registra a mensagem no arquivo de log.

<br>

`y)`

Se for y, exibe uma mensagem de erro e chama a função de alerta.

<br>

`*)`

Qualquer outro código indica que o servidor está offline, registrando um alerta.

<br>

## Remoção do arquivo de lock
`rm -f "$LOCKFILE"`
Remove o arquivo de bloqueio (caso tenha sido usado para evitar execução simultânea).

<br>

## Permissões e execução
`sudo chmod +x $VARIAVEL`

Torna o arquivo executável.

<br>

## Agendamento com cron
`CRON_JOB="*/1 * * * * echo \"[MENSAGEM]\" >> $VARIAVEL && /caminho/do/arquivo >> $VARIAVEL 2>&1"`

Aqui, a variável CRON_JOB armazena um comando que será agendado no cron.

- `*/1 * * * *` → Indica que o comando será executado a cada 1 minuto.
  - `*/1` → Significa "a cada um minuto".
  - `* * * *` → Representa os campos de tempo no cron:
    - Minuto (*/1): Executa a cada 1 minuto.
    - Hora (*): Qualquer hora.
    - Dia do mês (*): Qualquer dia.
    - Mês (*): Qualquer mês.
    - Dia da semana (*): Qualquer dia da semana.

- `echo \"[MENSAGEM]\" >> $VARIAVEL` → Adiciona a mensagem [MENSAGEM] ao arquivo referenciado por $VARIAVEL (sem sobrescrevê-lo).

- `/caminho/do/arquivo >> $VARIAVEL 2>&1` → Executa o script localizado em /caminho/do/arquivo e redireciona a saída padrão (stdout) e erros (stderr) para $VARIAVEL.
  - `>> $VARIAVEL` → Anexa a saída ao arquivo $VARIAVEL.
  - `2>&1` → Redireciona os erros (stderr, representado por 2) para a saída padrão (stdout, representado por 1), garantindo que tudo seja gravado no mesmo arquivo.


`( crontab -l 2>/dev/null; echo "$VARIAVEL" ) | crontab -`

Adiciona o job ao cron sem remover os existentes.

<br>

`sudo chmod 666 $VARIAVEL`

Garante permissões de leitura e escrita para todos.