YELLOW=$'\e[0;33m'
RESET=$'\e[0m'
GREEN=$'\e[0;32m'

autenticacao_ssh() {
  echo "Digite o seu email de acesso ao ${GREEN}github${RESET}:"
  read email
  echo "Digite o seu usuário do ${GREEN}github${RESET}:"
  read usuario

  if ! [ -x "$(command -v git)" ]; then
    sudo apt install git
  fi
  
  fish -c "git config --global user.name '$usuario'"
  fish -c "git config --global user.email '$email'"

  fish -c "ssh-keygen -t ed25519 -C '$email'"
  fish -c "eval (ssh-agent -c)"
  fish -c "ssh-add ~/.ssh/id_ed25519"

  echo "${YELLOW}Copie a sua chave e adicione ao github"

  fish -c "cat ~/.ssh/id_ed25519.pub"
}

autenticacao_ssh