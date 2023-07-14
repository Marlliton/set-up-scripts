instalar_node_js() {
  echo
  echo "${YELLOW}Instalando a versão lts do node${RESET}"
  fish -c "fnm install --lts"
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