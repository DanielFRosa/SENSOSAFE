<?php
require "db/conexao.php";
session_start();

/* ================= BLOCO DE EXCLUSÃO ================= */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['deletar_id'])) {

    $id = intval($_POST['deletar_id']);

    if ($id > 0) {
        $conn->beginTransaction();

        try {
            $busca = $conn->prepare("SELECT codSensor FROM maquina WHERE codMaquina = ?");
            $busca->execute([$id]);
            $maquina = $busca->fetch(PDO::FETCH_ASSOC);

            if ($maquina) {
                $codSensor = $maquina['codSensor'];

                $conn->prepare("DELETE FROM alerta WHERE codMaquina = ?")->execute([$id]);
                $conn->prepare("DELETE FROM leitura_sensor WHERE codSensor = ?")->execute([$codSensor]);
                $conn->prepare("DELETE FROM sensor WHERE codSensor = ?")->execute([$codSensor]);
                $conn->prepare("DELETE FROM maquina WHERE codMaquina = ?")->execute([$id]);
            }

            $conn->commit();
            header("Location: lista-maquinas.php?sucesso=deletado");
            exit();

        } catch (Exception $e) {
            $conn->rollBack();
            $erro = "Erro ao deletar máquina.";
        }
    }
}

/* ================= LISTAGEM ================= */
$sql = "SELECT
m.codMaquina,
m.nome,
m.tipo,
m.setor,
m.numeroSerie,
s.nomeExibicao AS sensor_nome,
s.tipo AS sensor_tipo
FROM maquina m
 JOIN maquina_sensor ms ON m.codMaquina = ms.codMaquina
 JOIN sensor s ON ms.codSensor = s.codSensor
ORDER BY m.codMaquina DESC;
";

$stmt = $conn->prepare($sql);
$stmt->execute();
$maquinas = $stmt->fetchAll(PDO::FETCH_ASSOC);

/* ================= MENSAGENS ================= */
$mensagem = "";
if (isset($_GET['sucesso'])) {
    if ($_GET['sucesso'] === 'deletado') $mensagem = "Máquina deletada com sucesso!";
    elseif ($_GET['sucesso'] === 'editado') $mensagem = "Máquina editada com sucesso!";
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>SensoSafe - Gerenciar Máquinas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/lista-maquinas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<nav class="Navbar">
    <div class="Logo">
        <a href="index.php"><img style="width:200px" src="img/logo.png" alt="SensoSafe"></a>
    </div>
    <div class="Menu">
        <a href="cadastro-maquina.php">Cadastrar Máquina</a>
        <a href="painel-adm.php">Painel ADM</a>
        <a href="dashboard.php">VOLTAR</a>
    </div>
</nav>

<main class="container">
<div class="content">

<div class="header">
    <h1><i class="fas fa-cogs"></i> Gerenciar Máquinas</h1>
    <a href="cadastro-maquina.php" class="btn-novo">
        <i class="fas fa-plus"></i> Nova Máquina
    </a>
</div>

<?php if ($mensagem): ?>
    <div class="mensagem-sucesso"><?= htmlspecialchars($mensagem) ?></div>
<?php endif; ?>

<?php if (!empty($erro)): ?>
    <div class="mensagem-erro"><?= htmlspecialchars($erro) ?></div>
<?php endif; ?>

<?php if (empty($maquinas)): ?>
    <div class="sem-dados">
        <i class="fas fa-info-circle"></i>
        <p>Nenhuma máquina cadastrada ainda.</p>
        <a href="cadastro-maquina.php" class="btn-cadastrar">Cadastrar Primeira Máquina</a>
    </div>
<?php else: ?>

<div class="busca-container">
    <input type="text" id="busca" placeholder="Buscar máquina por nome, tipo, setor ou nº de série...">
    <i class="fas fa-search"></i>
</div>

<div class="tabela-container">
<table class="tabela-maquinas">
<thead>
<tr>
    <th>ID</th>
    <th>Nome</th>
    <th>Tipo</th>
    <th>Setor</th>
    <th>Nº Série</th>
    <th>Sensor</th>
    <th>Ações</th>
</tr>
</thead>
<tbody>
<?php foreach ($maquinas as $maquina): ?>
<tr
    data-nome="<?= strtolower($maquina['nome']) ?>"
    data-tipo="<?= strtolower($maquina['tipo']) ?>"
    data-setor="<?= strtolower($maquina['setor']) ?>"
    data-serie="<?= strtolower($maquina['numeroSerie']) ?>"
>
    <td>#<?= $maquina['codMaquina'] ?></td>
    <td><?= htmlspecialchars($maquina['nome']) ?></td>
    <td><?= htmlspecialchars($maquina['tipo']) ?></td>
    <td><?= htmlspecialchars($maquina['setor']) ?></td>
    <td><?= htmlspecialchars($maquina['numeroSerie']) ?></td>
    <td>
        <?php if ($maquina['sensor_nome']): ?>
            <span class="sensor-info">
                <i class="fas fa-microchip"></i>
                <?= htmlspecialchars($maquina['sensor_nome']) ?>
            </span>
        <?php else: ?>
            <span class="sem-sensor">Sem sensor</span>
        <?php endif; ?>
    </td>
    <td class="acoes">
        <a href="editar-maquina.php?id=<?= $maquina['codMaquina'] ?>" class="btn-editar">
            <i class="fas fa-edit"></i> Editar
        </a>

        <a href="dashboard.php?id=<?= $maquina['codMaquina'] ?>" class="btn-visualizar">
            <i class="fas fa-eye"></i> Ver
        </a>

        <form method="POST" onsubmit="return confirm('Tem certeza que deseja deletar esta máquina?')" style="display:inline;">
            <input type="hidden" name="deletar_id" value="<?= $maquina['codMaquina'] ?>">
            <button type="submit" class="btn-deletar">
                <i class="fas fa-trash"></i> Deletar
            </button>
        </form>
    </td>
</tr>
<?php endforeach; ?>
</tbody>
</table>
</div>

<div class="resumo">
    <p><i class="fas fa-chart-bar"></i> Total de máquinas: <strong><?= count($maquinas) ?></strong></p>
</div>

<?php endif; ?>
</div>
</main>

<!-- ===== BUSCA INTELIGENTE ===== -->
<script>
document.addEventListener('DOMContentLoaded', function () {

    const inputBusca = document.getElementById('busca');
    if (!inputBusca) return;

    const linhas = document.querySelectorAll('.tabela-maquinas tbody tr');

    function normalizar(texto) {
        return texto.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
    }

    let timeout = null;

    inputBusca.addEventListener('input', function () {
        clearTimeout(timeout);

        timeout = setTimeout(() => {
            const termo = normalizar(this.value.trim());

            linhas.forEach(linha => {
                const nome = normalizar(linha.dataset.nome || "");
                const tipo = normalizar(linha.dataset.tipo || "");
                const setor = normalizar(linha.dataset.setor || "");
                const serie = normalizar(linha.dataset.serie || "");

                linha.style.display =
                    nome.includes(termo) ||
                    tipo.includes(termo) ||
                    setor.includes(termo) ||
                    serie.includes(termo)
                    ? "" : "none";
            });

        }, 150);
    });

});
</script>


</body>
</html>
