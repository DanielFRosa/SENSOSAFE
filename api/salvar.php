<?php
require "../db/conexao.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $codSensor  = $_POST['codSensor'] ?? null;
    $codMaquina = $_POST['codMaquina'] ?? null;
    $valor      = $_POST['valor'] ?? null;

    if ($codSensor && $codMaquina && $valor !== null) {

        $stmt = $conn->prepare("
            INSERT INTO leitura_sensor (codSensor, codMaquina, valor, dataHora)
            VALUES (?, ?, ?, NOW())
        ");

        if ($stmt->execute([$codSensor, $codMaquina, $valor])) {
            echo "OK";
        } else {
            echo "Erro ao inserir";
        }

    } else {
        echo "Dados inválidos";
    }
}