let usuario = document.getElementById('usuario');
let senha = document.getElementById('senha');
let mensagem = document.getElementById('mensagem');
let botao = document.getElementById('btn-login');

botao.addEventListener('click', () => {
  if (!usuario.value || !senha.value) {
    mensagem.textContent = 'Preencha todos os campos!';
    mensagem.classList.add('ativa');

    setTimeout(() => {
      mensagem.classList.remove('ativa');
    }, 3000);

    return;
  }

  mensagem.textContent = '';
  mensagem.classList.remove('ativa');
});
