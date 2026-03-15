<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SensoSafe | Demonstração</title>
    <link rel="stylesheet" href="css/demonstracao.css">
</head>

<body>

<nav class="Navbar">
    <div class="Logo">
        <a href="index.php">
            <img src="img/logo.png" alt="Logo SensoSafe" style="width: 200px;">
        </a>
    </div>

    <!-- BOTÃO HAMBÚRGUER (mobile) -->
    <div class="hamburger" onclick="toggleMenu()">
        <span></span>
        <span></span>
        <span></span>
    </div>

    <div class="Menu" id="menuMobile">
        <a href="index.php">INÍCIO</a>
        <a href="sobre.php">SOBRE</a>
        <a href="faleconosco.php">FALE CONOSCO</a>
    </div>
</nav>


    <main class="container">

        <section class="machine-box">
            <div class="machine-info">
                <h2>Motor Elétrico Industrial</h2>
                <p>Exemplo de equipamento monitorado pelo sistema</p>
                <span class="badge normal" id="status">Operação Normal</span>
            </div>

            <div class="machine-actions">
                <button class="btn simular" id="btnSimular">
                    Simular Falha
                </button>
            </div>
        </section>

        <section class="cards">
            <div class="card">
                <span>Temperatura</span>
                <strong id="temp">82 °C</strong>
            </div>

            <div class="card">
                <span>Vibração</span>
                <strong id="vib">4.1 mm/s</strong>
            </div>

            <div class="card">
                <span>Rotação</span>
                <strong id="rpm">1750 RPM</strong>
            </div>
        </section>

        <section class="alert-demo" id="alertBox">
            <h3 id="alertTitle">Sistema Estável</h3>
            <p id="alertText">
                Os sensores indicam funcionamento dentro dos parâmetros esperados.
            </p>
        </section>

        <section class="explain">
            <h3>Como funciona a demonstração?</h3>
            <p>
                Esta simulação representa como o sistema SensoSafe detecta alterações
                nos sensores de uma máquina industrial e gera alertas inteligentes
                antes que ocorram falhas críticas.
            </p>
        </section>

    </main>

    <script src="js/demonstracao.js" defer></script>
    <script>
function toggleMenu() {
    document.getElementById("menuMobile").classList.toggle("active");
}
</script>

</body>
</html>
