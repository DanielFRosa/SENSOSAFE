<?php
session_start();
require("db/conexao.php");
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SensoSafe</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<nav class="Navbar">
    <div class="Logo">
        <a href="index.php">
            <img style="width: 200px;" src="img/logo.png" alt="Logo">
        </a>
    </div>

    <!-- BOTÃO HAMBÚRGUER (só aparece no mobile) -->
    <div class="hamburger" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <div class="Menu" id="menuMobile">
        <a href="index.php">INÍCIO</a>
        <a href="sobre.php">SOBRE</a>

        <?php if (isset($_SESSION['empresa_id'])): ?>
            <a href="dashboard.php">DASHBOARDS</a>
        <?php endif; ?>

        <a href="faleconosco.php">FALE CONOSCO</a>
    </div>
</nav>


    <h1 id="mensagem">
        Transforme sua Indústria com
        Inteligência e Colaboração
    </h1>

    <div class="botoes">
    <?php if (!isset($_SESSION['usuario']) && !isset($_SESSION['empresa_id'])): ?>
        <a href="login.php">Login</a>
        <a href="cadastro.php">Cadastro</a>

    <?php elseif (isset($_SESSION['empresa_id'])): ?>
        <a href="dashboard.php">Dashboard</a>
        <a href="logout.php">Sair</a>

    <?php else: ?>
        <a href="logout.php">Sair</a>
    <?php endif; ?>
</div>

    <div vw class="enabled">
        <div vw-access-button class="active"></div>
    <div vw-plugin-wrapper>
        <div class="vw-plugin-top-wrapper"></div>
    </div>
    </div>

    <script src="https://vlibras.gov.br/app/vlibras-plugin.js"></script>
    <script>
        new window.VLibras.Widget('https://vlibras.gov.br/app');
    </script>
<script>
function toggleMenu() {
    document.getElementById("menuMobile").classList.toggle("active");
}
</script>

</body>
</html>
