<?php
session_start(); // garante acesso à sessão atual

// remove todas as variáveis de sessão
session_unset();

// destrói a sessão
session_destroy();

// redireciona para a página inicial
header("Location: index.php");
exit();
