<?php
require "../db/conexao.php";
require "../db/ferramentas.php";

header('Content-Type: application/json');
date_default_timezone_set('America/Sao_Paulo');

// Pegando ID da máquina
$idMaquina = $_GET['id'] ?? null;
if (!$idMaquina) {
    echo json_encode([]);
    exit;
}

// ===============================
// BUSCAR DADOS DOS SENSORES
// ===============================
$stmt = $conn->prepare("
    SELECT 
        m.codMaquina,
        m.nome AS nomeMaquina,
        s.codSensor,
        s.tipo,
        s.nomeExibicao,
        s.unidade,
        l.valor,
        l.dataHora
    FROM maquina m
    JOIN maquina_sensor ms ON m.codMaquina = ms.codMaquina
    JOIN sensor s ON ms.codSensor = s.codSensor
    LEFT JOIN leitura_sensor l 
        ON l.codSensor = s.codSensor 
        AND l.codMaquina = m.codMaquina
    WHERE m.codMaquina = ?
    ORDER BY l.dataHora ASC
");
$stmt->execute([$idMaquina]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
// ===============================
// ORGANIZAR SENSORES POR MÁQUINA
// ===============================
$maquinas = [];

foreach ($rows as $row) {
    $codMaquina = $row['codMaquina'];
    $codSensor  = $row['codSensor'];

    if (!isset($maquinas[$codMaquina])) {
        $maquinas[$codMaquina] = [
            'id' => $codMaquina,
            'nomeMaquina' => $row['nomeMaquina'],
            'sensores' => []
        ];
    }

    if (!isset($maquinas[$codMaquina]['sensores'][$codSensor])) {
        $maquinas[$codMaquina]['sensores'][$codSensor] = [
            'id' => $codSensor,
            'nome' => $row['nomeExibicao'],
            'unidade' => $row['unidade'],
            'grafico' => ($row['tipo'] === 'estado') ? 'bar' : 'line',
            'valores' => [],
            'labels' => [],
            'limiteAtencao' => $row['limiteAtencao'] ?? 80,
            'limiteCritico' => $row['limiteCritico'] ?? 100
        ];
    }

    if (!is_null($row['valor']) && !is_null($row['dataHora'])) {
        $maquinas[$codMaquina]['sensores'][$codSensor]['valores'][] = (float)$row['valor'];
        $dt = new DateTime($row['dataHora'], new DateTimeZone('America/Sao_Paulo'));
        $maquinas[$codMaquina]['sensores'][$codSensor]['labels'][] = $dt->format('Y-m-d\TH:i:s');
    }
}

// ===============================
// CALCULAR ESTATÍSTICAS E NÍVEL DE RISCO
// ===============================
foreach ($maquinas as &$maquina) {
    foreach ($maquina['sensores'] as &$sensor) {
        // Estatísticas
        $valores = $sensor['valores'];
        $min = !empty($valores) ? min($valores) : 0;
        $max = !empty($valores) ? max($valores) : 0;
        $media = !empty($valores) ? array_sum($valores)/count($valores) : 0;

        $sensor['min'] = $min;
        $sensor['max'] = $max;
        $sensor['media'] = $media;

        // Nível de risco baseado nos limites
        if (!empty($valores)) {
    // Calcula estatística usando a função que já define NORMAL, CRITICO, EMERGENCIA
    $estatistica = calcularEstatistica($valores);
    $sensor['nivelRisco'] = $estatistica['nivelRisco'];
    $sensor['media'] = $estatistica['media'];
    $sensor['desvio'] = $estatistica['desvio'];
    $sensor['zScore'] = $estatistica['zScore'];
} else {
    $sensor['nivelRisco'] = "NORMAL";
    $sensor['media'] = 0;
    $sensor['desvio'] = 0;
    $sensor['zScore'] = 0;
}
    }

    // Reindexar sensores
    $maquina['sensores'] = array_values($maquina['sensores']);
}
unset($maquina, $sensor);

// Retornar JSON
echo json_encode(array_values($maquinas), JSON_UNESCAPED_UNICODE);