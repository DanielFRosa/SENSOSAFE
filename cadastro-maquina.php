<?php
require "db/conexao.php";
require "db/ferramentas.php";

$mensagemErro = "";

if (isset($_POST['btnProximo'])) {

    $nome = LimpaPost($_POST['nomeMaquina']);
    $serie = LimpaPost($_POST['serie']);
    $tipo = LimpaPost($_POST['tipo']);
    $setor = LimpaPost($_POST['setor']);
    $status = LimpaPost($_POST['status']);
    $sensorNumero = LimpaPost($_POST['sensores']);
    $tipoSensor = LimpaPost($_POST['tipoSensor']);
    $unidadeSensor = LimpaPost($_POST['unidadeSensor']);

    if (
        empty($nome) || empty($serie) || empty($tipo) ||
        empty($setor) || empty($status) ||
        empty($sensorNumero) || empty($tipoSensor) || empty($unidadeSensor)
    ) {
        $mensagemErro = "Preencha todos os campos.";
    } else {

        $codEmpresa = 1;

        try {
            $sqlSensor = $conn->prepare("
                INSERT INTO sensor (tipo, nomeExibicao, unidade)
                VALUES (?, ?, ?)
            ");
            $sqlSensor->execute([$tipoSensor, 'Sensor ' . $sensorNumero, $unidadeSensor]);
            $codSensor = $conn->lastInsertId();

            $sqlMaquina = $conn->prepare("
                INSERT INTO maquina (numeroSerie, setor, nome, tipo, codEmpresa)
                VALUES (?, ?, ?, ?, ?)
            ");
            $sqlMaquina->execute([$serie, $setor, $nome, $tipo, $codEmpresa]);
            $codMaquina = $conn->lastInsertId();

            $sqlRelacionamento = $conn->prepare("
                INSERT INTO maquina_sensor (codMaquina, codSensor)
                VALUES (?, ?)
            ");
            $sqlRelacionamento->execute([$codMaquina, $codSensor]);

            header("Location: cadastro-maquina.php?sucesso=1");
            exit();

        } catch (PDOException $e) {
            $mensagemErro = "Erro ao cadastrar. Tente novamente.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cadastro de Máquina | SensoSafe</title>
<link rel="stylesheet" href="css/cadastro-maquina.css">
</head>

<body>

<div class="container">

  <!-- IMAGEM -->
  <div class="imagem"></div>

  <!-- FORMULÁRIO -->
  <div class="login">

    <div class="form">
    <a class="logo" href="painel-adm.php">
                <img src="img/escudo.png" alt="SensoSafe">
            </a>
      <h2>Cadastro de Máquina</h2>
<?php if (!empty($mensagemErro)): ?>
        <div class="mensagem erro"><?= $mensagemErro ?></div>
      <?php endif; ?>

      <?php if (isset($_GET['sucesso'])): ?>
        <div class="mensagem sucesso">Máquina cadastrada com sucesso!</div>
      <?php endif; ?>
      <form method="POST" novalidate>

        <label>Nome da Máquina</label>
        <input type="text" name="nomeMaquina">

        <label>Número de Série</label>
        <input type="text" name="serie">

        <label>Tipo de Máquina</label>
        <input type="text" name="tipo">

        <label>Setor</label>
        <input type="text" name="setor">

        <label>Status</label>
        <select id="status" name="status">
          <option value="">Selecione o status</option>
          <option value="ATIVA">ATIVA</option>
          <option value="DESLIGADA">DESLIGADA</option>
          <option value="EM_MANUTENCAO">EM MANUTENÇÃO</option>
        </select>

        <label>Número/ID do Sensor</label>
        <input type="text" name="sensores">

        <label>Tipo de Sensor</label>
        <input type="text" name="tipoSensor">

        <label>Unidade de Medida</label>
        <input type="text" name="unidadeSensor">

        <div class="button-group">
          <button type="button" class="btn cancel"
            onclick="window.location.href='index.php'">
            Cancelar
          </button>

          <button type="submit" class="btn submit" name="btnProximo">
            Próximo
          </button>
        </div>

      </form>
    </div>

  </div>
</div>

</body>
</html>
