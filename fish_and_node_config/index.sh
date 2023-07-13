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

  # oh-my-fish
  fish -c "curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish"

  echo
  echo "${GREEN}Fish Shell instalado com sucesso${RESET}"
}

instalar_fish_shell

instalar_node_js() {
  echo
  echo "${YELLOW}Instalando a versão lts do node${RESET}"
  fish -c "fnm install v16.20.1"
}

instalar_fnm_node_mananer() {
  echo
  echo "${YELLOW}Instalando fnm...${RESET}"
  # Executar o comando fish e passar o comando fisher install jorgebucaran/nvm.fish como argumento
  fish -c "curl -fsSL https://fnm.vercel.app/install | bash"

  echo "${YELLOW}Setando variável de ambiente para FNM...${RESET}"
  fish -c "set PATH '/home/marlliton/.local/share/fnm' '$PATH'"
  fish -c "fnm env | source"

  instalar_node_js

  echo "${GREEN}[Configuração do fish e nvm completa]${RESET}"
}

instalar_fnm_node_mananer

definir_fish_como_padrao() {
  echo
  echo "[DEFININDO FISH COMO SHELL PADRÃO]"
  echo "Insira sua senha de root se necessário:"
  chsh -s /usr/bin/fish

  echo
  echo "${GREEN}[SHELL PADRÃO AGORA É O FISH]${RESET}"
}

definir_fish_como_padrao

