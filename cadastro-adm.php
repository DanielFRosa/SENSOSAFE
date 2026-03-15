<?php
session_start();
require "db/conexao.php";
require "db/ferramentas.php";

if (!isset($_SESSION['empresa_id'])) {
    header("Location: cadastro.php");
    exit();
}

$mensagem = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $nome       = trim(post('nome'));
    $cpf        = limparNumeros(post('cpf'));
    $senha      = post('senha');
    $confirmar  = post('confirmar-senha');
    $codEmpresa = $_SESSION['empresa_id'];

    if (!$nome || !$cpf || !$senha || !$confirmar) {
        $mensagem = msg("Preencha todos os campos.", true);
    }
    elseif (!validarCPF($cpf)) {
        $mensagem = msg("CPF inválido.", true);
    }
    elseif (existe($conn, "SELECT codadm FROM administrador WHERE cpf = ?", [$cpf])) {
        $mensagem = msg("Este CPF já está cadastrado.", true);
    }
    elseif ($senha !== $confirmar) {
        $mensagem = msg("As senhas não coincidem.", true);
    }
    elseif (!validarSenha($senha)) {
        $mensagem = msg("A senha deve ter no mínimo 8 caracteres, uma letra minúscula e um símbolo.", true);
    }
    else {
        $senhaHash = password_hash($senha, PASSWORD_DEFAULT);

        inserir($conn, "administrador", [
            "nome"       => $nome,
            "cpf"        => $cpf,
            "senha"      => $senhaHash,
            "codEmpresa" => $codEmpresa
        ]);

        header("Location: index.php");
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cadastro Administrador | SensoSafe</title>
  <link rel="stylesheet" href="css/cadastro-adm.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<div class="container">

  <!-- IMAGEM -->
  <div class="imagem"></div>

  <!-- FORMULÁRIO NA MESMA POSIÇÃO -->
  <div class="login">

    <div class="form">
    <a class="logo" href="#">
                <img src="img/escudo.png" alt="SensoSafe">
            </a>
      <h2>Cadastrar Administrador</h2>

      <?= $mensagem ?>

      <form method="POST" novalidate>

        <label>Nome</label>
        <input type="text" name="nome" value="<?= htmlspecialchars(post('nome')) ?>">

        <label>CPF</label>
        <input type="text" name="cpf" value="<?= htmlspecialchars(post('cpf')) ?>">

        <label>Senha</label>
<div class="senha-box">
  <input type="password" name="senha" id="senhaAdm">
  <span class="toggle-senha" onclick="toggleSenha('senhaAdm', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>

<label>Confirmar Senha</label>
<div class="senha-box">
  <input type="password" name="confirmar-senha" id="confirmarSenhaAdm">
  <span class="toggle-senha" onclick="toggleSenha('confirmarSenhaAdm', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>

        <div class="button-group">
          <button type="button" class="btn cancel" onclick="window.location='index.php'">
            Cancelar
          </button>

          <button type="submit" class="btn submit">
            Próximo
          </button>
        </div>

      </form>
    </div>

  </div>
</div>
<script>
  function toggleSenha(id, elemento) {
  const input = document.getElementById(id);
  const icone = elemento.querySelector("i");

  if (input.type === "password") {
    input.type = "text";
    icone.classList.remove("fa-eye");
    icone.classList.add("fa-eye-slash");
  } else {
    input.type = "password";
    icone.classList.remove("fa-eye-slash");
    icone.classList.add("fa-eye");
  }
}
</script>
</body>
</html>