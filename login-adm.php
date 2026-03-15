<?php
session_start();
require "db/conexao.php";
require "db/ferramentas.php";

$mensagem = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $cpf   = limparNumeros(post('cpf'));
    $senha = post('senha');

    if (!$cpf || !$senha) {
        $mensagem = msg("Preencha todos os campos.", true);
    }
    elseif (!validarCPF($cpf)) {
        $mensagem = msg("CPF inválido.", true);
    }
    else {

        $stmt = $conn->prepare("
            SELECT codadm, nome, cpf, senha, codEmpresa
            FROM administrador
            WHERE cpf = ?
            LIMIT 1
        ");
        $stmt->execute([$cpf]);
        $adm = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($adm && password_verify($senha, $adm['senha'])) {

            $_SESSION['codAdm']      = $adm['codadm'];
            $_SESSION['nomeAdm']     = $adm['nome'];
            $_SESSION['codEmpresa']  = $adm['codEmpresa'];

            header("Location: painel-adm.php");
            exit;

        } else {
            $mensagem = msg("CPF ou senha inválidos.", true);
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
    

</head>

<body>

        <div class="container">
            <div class="imagem">

            </div>
            <div class="login">
    <a class="logo" href="index.php">
        <img src="img/escudo.png" alt="Logo da SensoSafe">
    </a>

    <div class="form">
        <h2>Login ADM</h2>

        <form method="POST">

            <label for="cpf">CPF</label>
            <input type="text" id="cpf" name="cpf" required>
            <label for="senha">Senha</label>
            <div class="senha-box">
                
  <input type="password" id="senha" name="senha" required>
  <span class="toggle-senha" onclick="toggleSenha('senha', this)">
    <i class="fa-solid fa-eye"></i>
  </span>
</div>
            <button type="submit" id="btn-login" name="">Entrar</button>
            <button type="submit" class="btn cancel" onclick="window.location='index.php'">Cancelar</button>

        </form>

        <div class="Mensagem">
            <?= $mensagem ?>
        </div>

    </div>
</div>


    </div>
    </div>
    <div vw class="enabled">
        <div vw-access-button class="active"></div>
        <div vw-plugin-wrapper>
          <div class="vw-plugin-top-wrapper"></div>
        </div>
      </div>
      <script src="https://vlibras.gov.br/app/vlibras-plugin.js"></script>
      <script>
        new window.VLibras.Widget('https://vlibras.gov.br/app');
      </script>
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
