<?php

$pdo = new PDO("mysql:host=localhost;dbname=sensoSafe;charset=utf8", "root", "");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$servidor = "localhost";
$banco = "sensoSafe";
$usuario = "root";
$senha = "";

try {
    $conn = new PDO("mysql:host=$servidor;dbname=$banco", $usuario, $senha);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $erro) {
    echo "Erro de conexão: " . $erro->getMessage();
}
