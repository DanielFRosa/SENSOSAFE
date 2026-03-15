<?php
require "db/conexao.php";
session_start();

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

if (!$id || $id <= 0) {
    header("Location: editar-maquina.php");
    exit();
}

$sqlMaquina = "
    SELECT m.*, ms.codSensor
    FROM maquina m
    LEFT JOIN maquina_sensor ms
        ON m.codMaquina = ms.codMaquina
    WHERE m.codMaquina = ?
";

$stmtMaquina = $conn->prepare($sqlMaquina);
$stmtMaquina->execute([$id]);
$maquina = $stmtMaquina->fetch(PDO::FETCH_ASSOC);

if (!$maquina) {
    header("Location: editar-maquina.php");
    exit();
}

$sqlSensores = "SELECT codSensor, nomeExibicao FROM sensor";
$sensores = $conn->query($sqlSensores)->fetchAll(PDO::FETCH_ASSOC);

$erro = "";
$sucesso = false;
$mensagem = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $nome     = trim($_POST['nomeMaquina'] ?? '');
    $serie    = trim($_POST['serie'] ?? '');
    $tipo     = trim($_POST['tipo'] ?? '');
    $setor    = trim($_POST['setor'] ?? '');
    $sensorId = !empty($_POST['sensores']) ? intval($_POST['sensores']) : null;

    if (empty($nome) || empty($tipo) || empty($setor)) {

        $erro = "Preencha todos os campos obrigatórios.";

    } else {

        try {

            $conn->beginTransaction();

            $sqlUpdate = "
                UPDATE maquina
                SET nome = ?,
                    numeroSerie = ?,
                    tipo = ?,
                    setor = ?
                WHERE codMaquina = ?
            ";

            $stmtUpdate = $conn->prepare($sqlUpdate);
            $stmtUpdate->execute([
                $nome,
                $serie,
                $tipo,
                $setor,
                $id
            ]);

            $conn->prepare("DELETE FROM maquina_sensor WHERE codMaquina = ?")
                 ->execute([$id]);

            if ($sensorId) {
                $conn->prepare("INSERT INTO maquina_sensor (codMaquina, codSensor) VALUES (?, ?)")
                     ->execute([$id, $sensorId]);
            }

            $conn->commit();

            $maquina['nome']        = $nome;
            $maquina['numeroSerie'] = $serie;
            $maquina['tipo']        = $tipo;
            $maquina['setor']       = $setor;
            $maquina['codSensor']   = $sensorId;

            $sucesso  = true;
            $mensagem = "Máquina atualizada com sucesso!";

        } catch (PDOException $e) {

            $conn->rollBack();
            $erro = "Erro ao atualizar: " . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SensoSafe - Editar Máquina</title>
    <link rel="stylesheet" href="css/editar-maquina.css">
</head>
<body>

<nav class="Navbar">
    <div class="Logo">
        <a href="index.php">
            <img src="img/logo.png" alt="Logo" width="180">
        </a>
    </div>

    
    <div class="Menu">
        <a href="lista-maquinas.php">LISTA</a>
        <a href="painel-adm.php">PAINEL</a>
        <a href="lista-maquinas.php">VOLTAR</a>
    </div>
</nav>

<main class="content">

    <form method="POST" class="form-group">

        <div class="header">
            <h1>Editar Máquina</h1>
            <span class="maquina-id">
                ID: #<?= htmlspecialchars($maquina['codMaquina']); ?>
            </span>
        </div>

        <?php if ($erro): ?>
            <div class="mensagem-erro">
                <?= htmlspecialchars($erro); ?>
            </div>
        <?php endif; ?>

        <?php if ($sucesso): ?>
            <div class="mensagem-sucesso">
                <?= htmlspecialchars($mensagem); ?>
            </div>
        <?php endif; ?>

        <div class="form-grid">

            <div class="form-group">
                <label for="nomeMaquina">Nome da Máquina *</label>
                <input type="text"
                       id="nomeMaquina"
                       name="nomeMaquina"
                       value="<?= htmlspecialchars($maquina['nome']); ?>"
                       required>
            </div>

            <div class="form-group">
                <label for="serie">Número de Série</label>
                <input type="text"
                       id="serie"
                       name="serie"
                       value="<?= htmlspecialchars($maquina['numeroSerie']); ?>">
            </div>

            <div class="form-group">
                <label for="tipo">Tipo de Máquina *</label>
                <input type="text"
                       id="tipo"
                       name="tipo"
                       value="<?= htmlspecialchars($maquina['tipo']); ?>"
                       required>
            </div>

            <div class="form-group">
                <label for="setor">Setor *</label>
                <input type="text"
                       id="setor"
                       name="setor"
                       value="<?= htmlspecialchars($maquina['setor']); ?>"
                       required>
            </div>

            <div class="form-group full-width">
                <label for="sensores">Sensor Conectado</label>
                <select name="sensores" id="sensores">
                    <option value="">Selecione um sensor (opcional)</option>

                    <?php foreach ($sensores as $sensor): ?>
                        <option value="<?= $sensor['codSensor']; ?>"
                            <?= ($sensor['codSensor'] == $maquina['codSensor']) ? 'selected' : ''; ?>>
                            <?= htmlspecialchars($sensor['nomeExibicao']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

        </div>

        <div class="botoes-acao">
            <a href="lista-maquinas.php" class="btn-voltar">
                Voltar
            </a>

            <button type="submit" class="btn-salvar">
                Salvar Alterações
            </button>
        </div>

    </form>

</main>

<script>
document.querySelector('form').addEventListener('submit', function(e) {
    const nome = document.getElementById('nomeMaquina').value.trim();
    if (!nome) {
        e.preventDefault();
        alert('O nome da máquina é obrigatório.');
    }
});
</script>

</body>
</html>
