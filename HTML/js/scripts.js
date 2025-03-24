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