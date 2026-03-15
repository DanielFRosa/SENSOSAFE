<?php
require "../db/conexao.php";

$id = $_GET['id'] ?? null;
if (!$id) {
    echo '';
    exit;
}

$stmt = $conn->prepare("
    SELECT MAX(dataHora) AS ultimaData
    FROM leitura_sensor
    WHERE codSensor IN (
        SELECT codSensor FROM maquina_sensor WHERE codMaquina = ?
    )
");
$stmt->execute([$id]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!empty($row['ultimaData'])) {
    date_default_timezone_set('America/Sao_Paulo');
    $dt = new DateTime($row['ultimaData']);
    echo $dt->format('H:i:s');
}