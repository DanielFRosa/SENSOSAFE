<?php
//====================//========================
session_start();
require "db/conexao.php";
require "db/ferramentas.php";

if (!isset($_SESSION['empresa_id'])) {
    header("Location: index.php");
    exit();
}
//====================//========================

$empresaId = $_SESSION['empresa_id'];
$setorSelecionado = $_GET['setor'] ?? null;


//====================//========================
$setoresStmt = $conn->prepare("SELECT DISTINCT setor FROM maquina WHERE codEmpresa = ? ORDER BY setor");
$setoresStmt->execute([$empresaId]);
$setores = $setoresStmt->fetchAll(PDO::FETCH_COLUMN);
//Se você tem 50 máquinas no setor "Usinagem", o DISTINCT faz com que a palavra "Usinagem" apareça apenas uma vez na lista.

if ($setorSelecionado) {
    $stmtLista = $conn->prepare("SELECT codMaquina FROM maquina WHERE setor = ? AND codEmpresa = ? ORDER BY codMaquina");
    $stmtLista->execute([$setorSelecionado, $empresaId]);
} else {
    $stmtLista = $conn->prepare("SELECT codMaquina FROM maquina WHERE codEmpresa = ? ORDER BY codMaquina");
    $stmtLista->execute([$empresaId]);
}

$dados = $stmtLista->fetchAll(PDO::FETCH_ASSOC);
$ids = array_column($dados, 'codMaquina');
$id = $_GET['id'] ?? ($ids[0] ?? null);

//====================//========================

$maquina = null;
$sensores = [];
$anterior = null;
$proxima = null;

if ($id) {
    // Busca os dados da máquina
    $stmt = $conn->prepare("SELECT * FROM maquina WHERE codMaquina = ? AND codEmpresa = ?");
    $stmt->execute([$id, $empresaId]);
    $maquina = $stmt->fetch(PDO::FETCH_ASSOC);

    //====================//========================
    if ($maquina) {
        // Esta consulta realiza uma junção relacional tripla. Ela parte da tabela de vínculo (maquina_sensor), anexa as propriedades fixas do sensor e tenta acoplar o estado dinâmico mais recente (leitura_sensor).
        //LEFT JOIN + MAX: É a parte mais inteligente. Garante que você veja o card do sensor mesmo que ele não tenha dados (LEFT JOIN) e traz apenas a informação mais recente do sensor (MAX(dataHora)), ignorando o histórico antigo para o painel principal.
     $stmt = $conn->prepare("
    SELECT 
        m.status,
        s.codSensor,
        s.nomeExibicao,
        s.unidade,
        ls.valor AS valorAtual,
        ls.dataHora AS dataAtualizacao
    FROM maquina_sensor ms
    JOIN maquina m
        ON m.codMaquina = ms.codMaquina
    JOIN sensor s 
        ON s.codSensor = ms.codSensor
    LEFT JOIN leitura_sensor ls 
        ON ls.codSensor = s.codSensor
        AND ls.dataHora = (
            SELECT MAX(dataHora) 
            FROM leitura_sensor 
            WHERE codSensor = s.codSensor
        )
    WHERE ms.codMaquina = ?
");
//LEFT JOIN: "Eu quero ver todos os meus carrinhos. Se tiver pilha, ótimo! Se não tiver, eu quero ver o carrinho do mesmo jeito."
//RESULTADO: O carrinho aparece, mas o lugar da pilha fica vazio.


$stmt->execute([$id]);
$sensores = $stmt->fetchAll(PDO::FETCH_ASSOC);

//====================//========================
//O !== diz que o resultado estritamente diferente de falso. Usamos isso porque a função array_search pode retornar o número 0 . Para o PHP, o número 0 e o valor 'falso' podem ser parecidos, ele entende que o número zero representa ausência, assim como o falso.

        if (($posicao = array_search($id, $ids)) !== false) {
            $anterior = $ids[$posicao - 1] ?? null;
            $proxima  = $ids[$posicao + 1] ?? null;
        }
    }
}
//====================//========================

?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>SensoSafe</title>
    <link rel="stylesheet" href="css/dashboard.css">]
    <script src="js/dashboard.js" defer></script>
</head>
<body>

<nav class="Navbar">
    <div class="Logo">
        <a href="index.php"><img style="width:200px" src="img/logo.png"></a>
    </div>

    <div class="Menu">
        <a href="index.php">INÍCIO</a>
        <a href="dashboard.php">DASHBOARDS</a>
        <a href="login-adm.php">PAINEL DO ADM</a>
    </div>

    <!-- filtro de setor -->
    <form method="GET">
        <select class="setor" name="setor" id="setor">
            <option value="">Todos setores</option>
            <?php foreach ($setores as $setor): ?>
                <option value="<?= $setor ?>" <?= $setor == $setorSelecionado ? 'selected' : '' ?>>
                    <?= $setor ?>
                </option>
            <?php endforeach; ?>
        </select>
    </form>
</nav>

<main class="dashboard">
<div class="notificacao">
    <section class="maquina-header">
        <div class="maquina-info">
            <h1><?= $maquina['nome'] ?? '' ?></h1>
            <p>Tipo: <?= $maquina['tipo'] ?? '' ?></p>
            <p>Setor: <?= $maquina['setor'] ?? '' ?></p>
            <p>Nº Série: <?= $maquina['numeroSerie'] ?? '' ?></p>
        </div>
    </section>
    <section class="graficos-sensores" id="graficos-sensores">

               </section>
</div>
   
<section class="navegacao-maquinas">
<?php
// botões de navegação entre máquinas
if ($anterior) {
    echo '<a href="dashboard.php?id=' . $anterior . '&setor=' . urlencode($setorSelecionado) . '">';
    echo '<button class="nav-btn">⬅ Máquina anterior</button>';
    echo '</a>';
}
//urlencode pega caracteres com ç, ã, espaços.. e transforma em um formato especial. ex.:( ) vira (%20).

if ($proxima) {
    echo '<a href="dashboard.php?id=' . $proxima . '&setor=' . urlencode($setorSelecionado) . '">';
    echo '<button class="nav-btn">Próxima máquina ➡</button>';
    echo '</a>';
}
?>
</section>



<section class="painel-sensores">
<div id="sensor-card">
</div>
<div class="status">
<h3>status da máquina:</h3>
<p class="valor">
<?php 
foreach ($sensores as $sensor) {
    echo $sensor['status'];
}
?>
</p>
</div>

<div class="alerta">
<h3>Alerta:</h3>
<div class="area-alerta">
    
</div>
</div>

<div class="horario">
<h3>Última leitura:</h3>
<p  class="valor" id="ultima-leitura"></p>
</section>


</main>
<script>
const MAQUINA_ID = "<?= $id ?? '' ?>";
</script>

 <script>
          document.getElementById("setor").addEventListener("change", function() {
               this.form.submit();
          });
     </script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns"></script>





</body>
</html>
