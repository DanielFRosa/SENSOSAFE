<?php
session_start();
require "db/conexao.php";
require "db/ferramentas.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $empresa   = trim(post('empresa'));
    $cnpj      = limparNumeros(post('cnpj'));
    $email     = trim(post('email'));
    $telefone  = trim(post('telefone'));
    $senha     = post('senha');
    $confirmar = post('confirmar-senha');

    if (!$empresa || !$cnpj || !$email || !$telefone || !$senha || !$confirmar) {
        $erro = "Preencha todos os campos.";
    } elseif (strlen($cnpj) !== 14) {
        $erro = "CNPJ inválido.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $erro = "E-mail inválido.";
    } elseif (existe($conn, "SELECT codEmpresa FROM empresa WHERE cnpj = ?", [$cnpj])) {
        $erro = "Este CNPJ já está cadastrado.";
    } elseif (existe($conn, "SELECT codEmpresa FROM empresa WHERE email = ?", [$email])) {
        $erro = "Este e-mail já está cadastrado.";
    } elseif ($senha !== $confirmar) {
        $erro = "As senhas não coincidem.";
    } elseif (!validarSenha($senha)) {
        $erro = "A senha deve ter no mínimo 8 caracteres, uma letra minúscula e um símbolo.";
    } else {

        $senhaHash = password_hash($senha, PASSWORD_DEFAULT);

        inserir($conn, "empresa", [
            "nome"     => $empresa,
            "cnpj"     => $cnpj,
            "email"    => $email,
            "telefone" => $telefone,
            "senha"    => $senhaHash
        ]);

        $novoId = $conn->lastInsertId();

        $_SESSION['empresa_id']   = $novoId;
        $_SESSION['empresa_nome'] = $empresa;

   
        header("Location: cadastro-adm.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cadastro | SensoSafe</title>
  <link rel="stylesheet" href="css/cadastro.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

</head>

<body>

<div class="container">

  <!-- IMAGEM IGUAL AO LOGIN -->
  <div class="imagem"></div>

  <!-- BLOCO DO FORMULÁRIO -->
  <div class="login">

    <div class="form">
    <a class="logo" href="#">
                <img src="img/escudo.png" alt="SensoSafe">
            </a>
      <h2>Cadastro da Empresa</h2>

      <form method="POST" novalidate>

<label>Empresa</label>
<input type="text" name="empresa" value="<?= htmlspecialchars(post('empresa')) ?>">

<label>CNPJ</label>
<input type="text" name="cnpj" value="<?= htmlspecialchars(post('cnpj')) ?>">

<label>E-mail</label>
<input type="email" name="email" value="<?= htmlspecialchars(post('email')) ?>">

<label>Telefone</label>
<input type="tel" name="telefone" value="<?= htmlspecialchars(post('telefone')) ?>">

<label>Senha</label>
<div class="senha-box">
  <input type="password" name="senha" id="senha">
  <span class="toggle-senha" onclick="toggleSenha('senha', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>

<label>Confirmar Senha</label>
<div class="senha-box">
  <input type="password" name="confirmar-senha" id="confirmarSenha">
  <span class="toggle-senha" onclick="toggleSenha('confirmarSenha', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>

<!-- BOTÕES -->
<div class="button-group">
  <button type="button" class="btn cancel"
    onclick="window.location.href='index.php'">
    Cancelar
  </button>

  <button type="submit" class="btn submit">
    Próximo
  </button>
</div>

</form>
    </div>

    <?php if (!empty($erro)): ?>
  <div class="mensagem erro"><?= $erro ?>
</div>
<?php endif; ?>
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