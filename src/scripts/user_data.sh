#!/usr/bin/env bash

# Configuração Inicial
# Esse script é executado no primeiro boot da instância EC2 (Ubuntu Server)
# Ele configura o servidor e instala o Nginx

# Atualiza a lista de pacotes do sistema e instala o Nginx
sudo apt update -y && sudo apt install nginx -y

# Criação da página HTML para o servidor Nginx
sudo cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servidor Web Monitorado</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/styles.css" rel="stylesheet">
</head>
<body class="dark-mode">
    <!-- Navbar Fixo -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
        <a class="navbar-brand" href="#">Servidor Web Monitorado</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link" href="#projeto">O Projeto</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="https://github.com/vinicius-emanuelds/servidor-web-monitorado" target="_blank">
                Documentação
                </a>
            </li>
            </ul>
        </div>
        <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" id="darkModeToggle" checked>
            <label class="form-check-label text-light" for="darkModeToggle">Modo Escuro</label>
        </div>
        </div>
    </nav>

    <!-- Conteúdo Principal -->
    <div class="container mt-5 pt-5">
        <!-- Seção Projeto -->
        <section id="projeto" class="my-5">
        <h1>Servidor Web Monitorado</h1>
        <p>
            Este projeto foi desenvolvido como parte do <strong>Scholarship</strong> da Compass UOL.
            O objetivo é configurar um servidor web na AWS, integrando monitoramento automático e notificações via Telegram.
            Utilizando AWS, Nginx e scripts customizados, a solução demonstra uma implantação robusta e escalável para ambientes reais.
        </p>
        <div class="row">
            <!-- Card Sobre Mim -->
            <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                <h5 class="card-title">SOBRE MIM</h5>
                <p class="card-text">Descubra minha jornada e o que me inspira no mundo do desenvolvimento.</p>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalSobreMim">
                    Acessar
                </button>
                </div>
            </div>
            </div>
            <!-- Card Configuração Manual -->
            <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                <h5 class="card-title">CONFIGURAÇÃO MANUAL</h5>
                <p class="card-text">Etapas para configuração manual do ambiente na AWS.</p>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalConfigManual">
                    Acessar
                </button>
                </div>
            </div>
            </div>
            <!-- Card Configuração com Userdata -->
            <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                <h5 class="card-title">CONFIGURAÇÃO COM USERDATA</h5>
                <p class="card-text">Implantação automatizada da instância EC2 com scripts de inicialização.</p>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalConfigUserdata">
                    Acessar
                </button>
                </div>
            </div>
            </div>
        </div>
        </section>
    </div>

    <!-- Modal Sobre Mim -->
    <div class="modal fade" id="modalSobreMim" tabindex="-1" aria-labelledby="modalSobreMimLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
            <h5 class="modal-title" id="modalSobreMimLabel">Sobre Mim</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body">
            <p>
                <strong>Olá! 👋 Meu nome é Vinicius</strong><br>
                <em>Aspirante à Desenvolvedor Full Stack</em><br><br>
                Graduando em Análise e Desenvolvimento de Sistemas, tenho 32 anos e estou em plena transição de carreira.
                Encontrei na programação a maneira perfeita de unir minhas habilidades, paixões e aptidões. Foi isso que me fez deixar
                a área da saúde e mergulhar de cabeça na tecnologia. Hoje, meu foco é no desenvolvimento full stack (front-end e back-end),
                criando aplicações que realmente façam a diferença na vida de milhares de usuários.
            </p>
            <p>
                Sou estudante na <a href="https://fatecmm.cps.sp.gov.br/" target="_blank" rel="noreferrer" class="text-info">FATEC Arthur de Azevedo</a>,
                uma das Faculdades de Tecnologia do Estado de São Paulo, na cidade de Mogi Mirim.
            </p>
            <p><strong>Contato e Informações:</strong></p>
            <ul>
                <li>🌍 Moro em Mogi Mirim, São Paulo.</li>
                <li>✉️ Contato: <a href="mailto:vinicius.emanuelds@gmail.com" class="text-info">vinicius.emanuelds@gmail.com</a></li>
                <li>🚀 Atualmente, sou estagiário em Cloud &amp; DevSecOps na Compass Uol, mas continuo atuando na área da saúde.</li>
                <li>🧠 Aprendendo DevSecOps, IaC, AWS Cloud e as linguagens C, Javascript, além de HTML e CSS.</li>
                <li>🤝 Aberto a colaborar em projetos de impacto social.</li>
            </ul>
            <p><strong>Skills:</strong></p>
            <p>
                <a href="https://docs.microsoft.com/en-us/cpp/?view=msvc-170" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/c/c-original.svg" width="36" height="36" alt="C" />
                </a>
                <a href="https://www.linux.org/" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linux/linux-original.svg" width="36" height="36" alt="Linux" />
                </a>
                <a href="https://aws.amazon.com/" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" width="36" height="36" alt="AWS Cloud" />
                </a>
                <a href="https://developer.mozilla.org/en-US/docs/Web/HTML" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" width="36" height="36" alt="HTML" />
                </a>
                <a href="https://developer.mozilla.org/en-US/docs/Web/CSS" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" width="36" height="36" alt="CSS" />
                </a>
                <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript" target="_blank" rel="noreferrer">
                    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" width="36" height="36" alt="JavaScript" />
                </a>
            </p>
            <p><strong>Estatísticas no GitHub:</strong></p>
            <p>
                <img src="https://github-readme-stats.vercel.app/api?username=vinicius-emanuelds&theme=transparent&bg_color=000&border_color=30A3DC&show_icons=true&icon_color=30A3DC&title_color=E94D5F&text_color=FFF" alt="GitHub Stats"><br>
                <a href="https://github.com/vinicius-emanuelds" target="_blank" rel="noreferrer">
                <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=vinicius-emanuelds&layout=compact&title_color=fff&text_color=f8f8f2&hide=java&bg_color=171c24" alt="Top Langs">
                </a>
            </p>
            <p><strong>Redes Sociais:</strong></p>
            <p>
                <a href="https://github.com/vinicius-emanuelds" target="_blank" rel="noreferrer">
                <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/github-dark.svg" width="32" height="32" alt="GitHub" />
                </a>
                <a href="https://www.linkedin.com/in/viniciusesilva/" target="_blank" rel="noreferrer">
                <img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/linkedin.svg" width="32" height="32" alt="LinkedIn" />
                </a>
            </p>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
        </div>
    </div>

    <!-- Modal Configuração Manual -->
    <div class="modal fade" id="modalConfigManual" tabindex="-1" aria-labelledby="modalConfigManualLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
            <h5 class="modal-title" id="modalConfigManualLabel">Configuração Manual</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body">
            <p>
                Estas são as etapas para a configuração manual do servidor web na AWS:
            </p>
            <ul>
                <li><strong>Ambiente:</strong> Criação da VPC com sub-redes públicas e privadas, configuração do Security Group e lançamento da instância EC2.</li>
                <li><strong>Instalação:</strong> Conexão via SSH, instalação do Nginx e criação de uma página HTML personalizada.</li>
                <li><strong>Monitoramento:</strong> Implementação de scripts para monitorar o servidor e enviar notificações (via Telegram) em caso de falhas.</li>
            </ul>
            <p>
                As instruções detalhadas encontram-se na documentação do projeto, disponível também no repositório.
            </p>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
        </div>
    </div>

    <!-- Modal Configuração com Userdata -->
    <div class="modal fade" id="modalConfigUserdata" tabindex="-1" aria-labelledby="modalConfigUserdataLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
            <h5 class="modal-title" id="modalConfigUserdataLabel">Configuração com Userdata</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Fechar"></button>
            </div>
            <div class="modal-body">
            <p>
                Nesta abordagem, a instância EC2 é automaticamente configurada por meio do campo <strong>User Data</strong>. O script inicial:
            </p>
            <ul>
                <li>Atualiza o sistema e instala o Nginx.</li>
                <li>Cria uma página HTML básica para testes.</li>
                <li>Configura scripts de monitoramento e status, com notificações via Telegram.</li>
                <li>Automatiza tarefas com o uso do Cron.</li>
            </ul>
            <p>
                Essa metodologia reduz a intervenção manual e agiliza a implantação do ambiente.
            </p>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
            </div>
        </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer mt-auto py-3 bg-dark">
        <div class="container">
        <span class="text-muted">Desenvolvido por Vinicius</span>
        <div class="float-end">
            <a href="https://aws.amazon.com/" class="text-light me-3">AWS</a>
            <a href="https://nginx.org/" class="text-light me-3">Nginx</a>
            <a href="https://webhook.site/" class="text-light me-3">WebHook</a>
            <a href="https://telegram.org/" class="text-light">Telegram</a>
        </div>
        </div>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- Custom JS -->
    <script src="js/scripts.js"></script>
</body>
</html>
EOF

# Criação do arquivo de estilo CSS
sudo mkdir -p /var/www/html/css
sudo cat << 'EOF' > /var/www/html/css/styles.css
/* styles.css */
body.dark-mode {
    background-color: #121212;
    color: #ffffff;
}

body.light-mode {
    background-color: #ffffff;
    color: #000000;
}

.navbar-dark .navbar-nav .nav-link {
    color: rgba(255, 255, 255, 0.75);
}

.navbar-dark .navbar-nav .nav-link:hover {
    color: rgba(255, 255, 255, 1);
}

.footer {
    background-color: #343a40;
    color: #ffffff;
}

.footer a {
    color: #ffffff;
    text-decoration: none;
}

.footer a:hover {
    color: #cccccc;
}

section {
    padding-top: 60px; /* Ajuste para o navbar fixo */
    margin-top: -60px; /* Compensa o espaçamento do navbar */
}
EOF

# Criação do arquivo de scripts JavaScript
sudo mkdir -p /var/www/html/js
sudo cat << 'EOF' > /var/www/html/js/scripts.js
// scripts.js
document.addEventListener('DOMContentLoaded', function() {
    // Scroll suave para links internos
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Toggle de modo escuro/claro
    const darkModeToggle = document.getElementById('darkModeToggle');
    const body = document.body;

    // Verifica o estado do modo escuro no localStorage
    const isDarkMode = localStorage.getItem('darkMode') === 'true';
    darkModeToggle.checked = isDarkMode;
    body.classList.toggle('dark-mode', isDarkMode);
    body.classList.toggle('light-mode', !isDarkMode);

    // Adiciona um listener para o toggle
    darkModeToggle.addEventListener('change', function() {
        const isDarkMode = darkModeToggle.checked;
        body.classList.toggle('dark-mode', isDarkMode);
        body.classList.toggle('light-mode', !isDarkMode);
        localStorage.setItem('darkMode', isDarkMode);
    });
});
EOF

# Habilita e inicia o serviço do Nginx
sudo systemctl enable nginx --now

# Criação do Script de Monitoramento
MONITOR_SCRIPT="/home/usuario/monitorar.sh"
LOG_DIR="/var/log/monitoramento"
mkdir -p $LOG_DIR

# Definindo as variáveis de log corretamente
LOGS="$LOG_DIR/monitorar.log"
LOGS_CRON="$LOG_DIR/cron_monitor.log"
LOGS_STATUS="$LOG_DIR/nginx_status.log"

# Verifica se os arquivos de log existem e os cria, se necessário
if [ ! -f "$LOGS" ]; then
    sudo touch "$LOGS"
    sudo chmod 666 "$LOGS"
fi

if [ ! -f "$LOGS_CRON" ]; then
    sudo touch "$LOGS_CRON"
    sudo chmod 666 "$LOGS_CRON"
fi

if [ ! -f "$LOGS_STATUS" ]; then
    sudo touch "$LOGS_STATUS"
    sudo chmod 666 "$LOGS_STATUS"
fi

sudo cat << 'EOF' > $MONITOR_SCRIPT
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
EOF

# Concede permissão de execução ao script
sudo chmod +x $MONITOR_SCRIPT

# Adiciona o script ao crontab para rodar a cada minuto e registra logs no arquivo dedicado
CRON_JOB="*/1 * * * * echo \"$(date) - Executando monitorar.sh\" >> $LOGS_CRON && /home/usuario/monitorar.sh >> $LOGS_CRON 2>&1"
( crontab -l 2>/dev/null; echo "$CRON_JOB" ) | crontab -

# Criação do arquivo de log para o crontab
sudo touch $LOGS_CRON
sudo chmod 666 $LOGS_CRON

# === Criação do Script de Status do Nginx ===
STATUS_SCRIPT="/home/usuario/nginx_status.sh"

sudo cat << 'EOF' > $STATUS_SCRIPT
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
EOF

# Torna o script de status executável
sudo chmod +x $STATUS_SCRIPT

# Criação do arquivo de log para o script de status
sudo touch $LOGS_STATUS
sudo chmod 666 $LOGS_STATUS

# Adiciona o script ao crontab para rodar a cada 2 minutos
CRON_STATUS="*/2 * * * * /home/usuario/nginx_status.sh >> $LOGS_STATUS 2>&1"
( crontab -l 2>/dev/null; echo "$CRON_STATUS" ) | crontab -
