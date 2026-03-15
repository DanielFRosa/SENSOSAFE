<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SensoSafe | Contato</title>
    <link rel="stylesheet" href="css/faleconosco.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<nav class="Navbar">
    <div class="Logo">
        <a href="index.php">
            <img src="img/logo.png" alt="Logo" style="width: 180px;">
        </a>
    </div>

    <!-- BOTÃO HAMBÚRGUER -->
    <div class="hamburger" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <div class="Menu" id="menuMobile">
        <a href="index.php">INÍCIO</a>
        <a href="sobre.php">SOBRE</a>
        <a href="faleconosco.php" class="active">FALE CONOSCO</a>
    </div>
</nav>

    <header class="Hero">
        <div class="headline">
            <h2>Fale com a SensoSafe</h2>

            <div class="cta-buttons">
                <a href="demonstracao.php" class="btn-primary">Solicitar demonstração</a>
                <a href="https://wa.me/seunumeroaqui" class="btn-secondary">
                    <i class="fab fa-whatsapp"></i> Falar com especialista
                </a>
            </div>
        </div>
    </header>

    <footer class="FooterCards">
        <div class="card">
            <i class="fas fa-map-marker-alt"></i>
            <div>
                <h4>Endereço</h4>
                <p>Rua da Tecnologia, 123 – Parque Industrial<br>Linhares – ES</p>
            </div>
        </div>
        <div class="card">
            <i class="fas fa-clock"></i>
            <div>
                <h4>Atendimento</h4>
                <p>Segunda a Sexta<br>09h às 18h</p>
            </div>
        </div>
        <div class="card">
            <i class="fas fa-envelope"></i>
            <div>
                <h4>Contato</h4>
                <p>sensosafecontact@gmail.com.br<br>(27) 4002-8922</p>
            </div>
        </div>
    </footer>

    <div vw class="enabled">
        <div vw-access-button class="active"></div>
        <div vw-plugin-wrapper>
          <div class="vw-plugin-top-wrapper"></div>
        </div>
    </div>
    <script src="https://vlibras.gov.br/app/vlibras-plugin.js"></script>
    <script>new window.VLibras.Widget('https://vlibras.gov.br/app');</script>
    <script>
function toggleMenu() {
    document.getElementById("menuMobile").classList.toggle("active");
}
</script>

</body>
</html>
