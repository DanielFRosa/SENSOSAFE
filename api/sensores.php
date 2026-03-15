<?php
require "../db/conexao.php";

$id = $_GET['id'] ?? null;
if (!$id) {
    echo json_encode([]);
    exit;
}

$stmt = $conn->prepare("
    SELECT s.codSensor,
           s.nomeExibicao,
           s.unidade,
           ls.valor AS valorAtual,
           ls.dataHora
    FROM maquina_sensor ms
    JOIN sensor s ON s.codSensor = ms.codSensor
    LEFT JOIN leitura_sensor ls 
        ON ls.codSensor = s.codSensor
        AND ls.dataHora = (
            SELECT MAX(dataHora)
            FROM leitura_sensor
            WHERE codSensor = s.codSensor
        )
    WHERE ms.codMaquina = ?
");

$stmt->execute([$id]);

header('Content-Type: application/json');
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));