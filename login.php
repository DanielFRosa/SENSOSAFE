<?php
require "db/conexao.php";
session_start();

$erro = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $email = trim($_POST['email'] ?? '');
    $senha = $_POST['senha'] ?? '';

    if (!$email || !$senha) {
        $erro = "Preencha todos os campos.";
    } else {

        $stmt = $conn->prepare("
            SELECT codEmpresa, nome, senha
            FROM empresa
            WHERE email = ?
        ");
        $stmt->execute([$email]);
        $empresa = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($empresa && password_verify($senha, $empresa['senha'])) {

            $_SESSION['empresa_id'] = $empresa['codEmpresa'];
            $_SESSION['empresa_nome'] = $empresa['nome'];

            header("Location: dashboard.php");
            exit;

        } else {
            $erro = "E-mail ou senha inválidos.";
        }
    }
}
?>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="css/login.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <script src="js/login.js" defer></script>
</head>

<body>

<div class="container">
  <div class="imagem"></div>

  <div class="login">
    <a class="logo" href="index.php">
      <img src="img/escudo.png" alt="Logo da SensoSafe">
    </a>

    <div class="form">
      <h2>Login</h2>

      <form method="POST" id="formLogin">

        <label for="email">E-mail</label>
        <input type="email" id="email" name="email" required>

        <label for="senha">Senha</label>
<div class="senha-box">
  <input type="password" id="senha" name="senha" required>
  <span class="toggle-senha" onclick="toggleSenha('senha', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>

        <div class="lembrar-esqueci">
          <div class="lembrar-box">
            <input type="checkbox" id="lembrar">
            <label for="lembrar">Lembrar minha senha.</label>
          </div>

        </div>

        <button type="submit" id="btn-login">Entrar</button>

        <!-- LINKS ABAIXO DO BOTÃO -->
        <div class="links-abaixo-botao">
          <a href="recuperar-senha.php" class="esqueci-senha">Esqueceu sua senha?</a>
          <a class="cadastro-link" href="cadastro.php">
            Não tem uma conta? Cadastre-se.
          </a>
        </div>

      </form>
    </div>

    <p id="mensagem" class="<?= $erro ? 'ativa' : '' ?>">
      <?= $erro ?>
    </p>
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
