YELLOW=$'\e[0;33m'
RESET=$'\e[0m'
GREEN=$'\e[0;32m'

instalar_fish_shell() {
  echo
  echo "${YELLOW}Adicionando o Fish Shell na lista de repositórios${RESET}"
  sudo apt-add-repository ppa:fish-shell/release-3

  echo
  echo "Atualizando apt"
  sudo apt update

  echo
  echo "Instalando o Fish Shell"
  sudo apt install fish

  echo
  echo "${GREEN}Fish Shell instalado com sucesso${RESET}"
}

instalar_fish_shell

definir_fish_como_padrao() {
  echo
  echo "[DEFININDO FISH COMO SHELL PADRÃO]"
  echo "Insira sua senha de root se necessário:"
  chsh -s /usr/bin/fish

  echo
  echo "${GREEN}[SHELL PADRÃO AGORA É O FISH]${RESET}"
}

definir_fish_como_padrao