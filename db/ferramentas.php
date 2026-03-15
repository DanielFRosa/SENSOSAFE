<?php

function limpaPost($valor)
{
    return trim($valor);
}


function validarSenha($senha)
{
    $regex = '/^(?=.*[a-z])(?=.*[^a-zA-Z0-9]).{8,}$/';
    return preg_match($regex, $senha) ? true : false;
}

function validarCPF($cpf)
{
    $cpf = preg_replace('/[^0-9]/', '', $cpf);

    if (strlen($cpf) != 11) {
        return false;
    }

    if (preg_match('/(\d)\1{10}/', $cpf)) {
        return false;
    }

    for ($t = 9; $t < 11; $t++) {
        $soma = 0;
        for ($c = 0; $c < $t; $c++) {
            $soma += $cpf[$c] * (($t + 1) - $c);
        }
        $resto = ($soma * 10) % 11;
        if ($resto == 10) $resto = 0;

        if ($cpf[$t] != $resto) {
            return false;
        }
    }

    return true;
}


function post($key) {
    return isset($_POST[$key]) ? trim($_POST[$key]) : null;
}

function limparNumeros($valor) {
    return preg_replace('/\D/', '', $valor);
}

function existe(PDO $conn, string $sql, array $params): bool {
    $stmt = $conn->prepare($sql);
    $stmt->execute($params);
    return (bool) $stmt->fetch();
}

function executar(PDO $conn, string $sql, array $params = []): bool {
    try {
        $stmt = $conn->prepare($sql);
        return $stmt->execute($params);
    } catch (PDOException $e) {
        die("ERRO SQL: " . $e->getMessage());
    }
}

function inserir(PDO $conn, string $tabela, array $dados): bool {

    if (empty($dados)) {
        return false;
    }

    $campos = implode(', ', array_keys($dados));
    $placeholders = implode(', ', array_fill(0, count($dados), '?'));

    $sql = "INSERT INTO {$tabela} ({$campos}) VALUES ({$placeholders})";

    return executar($conn, $sql, array_values($dados));
}



function msg(string $texto, bool $erro = false): string {
    $classe = $erro ? 'sucesso erro' : 'sucesso';
    return "<div class='$classe'>$texto</div>";
}

function atualizar(PDO $conn, string $tabela, array $dados, string $where, array $whereParams = []): bool {

    $set = implode(', ', array_map(
        fn($campo) => "$campo = ?",
        array_keys($dados)
    ));

    $sql = "UPDATE $tabela SET $set WHERE $where";

    return executar(
        $conn,
        $sql,
        array_merge(array_values($dados), $whereParams)
    );
}

function deletar(PDO $conn, string $tabela, string $campo, $valor) {
    executar($conn, "DELETE FROM $tabela WHERE $campo = ?", [$valor]);
}



function calcularEstatistica(array $valores): array
{
    $n = count($valores);

    if ($n <= 1) {
        return [
            'media' => 0,
            'desvio' => 0,
            'zScore' => 0,
            'nivelRisco' => 'NORMAL'
        ];
    }

    $media = array_sum($valores) / $n;

    $somaQuadrados = 0;
    foreach ($valores as $valor) {
        $somaQuadrados += pow($valor - $media, 2);
    }

    $desvio = sqrt($somaQuadrados / ($n - 1));

    $ultimoValor = end($valores);

    $z = ($desvio > 0)
        ? ($ultimoValor - $media) / $desvio
        : 0;

    $absZ = abs($z);

  
    if ($absZ >= 4) {
    $nivel = "EMERGENCIA";
}
elseif ($absZ >= 3 ) {
    $nivel = "CRITICO";
}
else {
    $nivel = "NORMAL";
}
    return [
        'media' => round($media, 2),
        'desvio' => round($desvio, 2),
        'zScore' => round($z, 2),
        'nivelRisco' => $nivel
    ];
}