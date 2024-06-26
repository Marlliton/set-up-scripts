# Define as sequências de escape ANSI para as cores
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
RESET=$'\e[0m'

executar_pos_instalacao() {
  echo "${GREEN}Atualizando o sistema e instando programas${RESET}"
  caminho_script="$PWD/post_install/index.sh"
  . "$caminho_script"
}

executar_instalacao_fish_shell() {
  echo "${GREEN}Executando o script de instalação do Fish Shell...${RESET}"
  caminho_script="$PWD/fish/set_up/index.sh"
  . "$caminho_script"
}

executar_config_oh_my_fish() {
  echo "${GREEN}Instalando OH_MY_FISH...${RESET}"
  caminho_script="$PWD/fish/oh_my_fish/index.sh"
  . "$caminho_script"
}

executar_configuracao_docker() {
  echo "${GREEN}Executando o script de configuração do doker...${RESET}"
  caminho_script="$PWD/docker_config/index.sh"
  . "$caminho_script"
}
 
executar_autenticacao_ssh_github() {
  echo "${GREEN}Executando o script de autenticação SSH...${RESET}"
  caminho_script="$PWD/github_config/index.sh"
  . "$caminho_script"
}


# Menu iterativo 
declare -a selected_options
while true; do
  clear
  echo "Selecione uma opção, exemplo: 2"
  
  selected_options_text=""

  for option in "${selected_options[@]}"; do
    selected_options_text+="* "
  done

  echo "$([[ "${selected_options[*]}" == *"0"* ]] && echo "${GREEN}*${RESET}") 0. Passo 0 atualizar o sistema e instalar principais programas"
  echo "$([[ "${selected_options[*]}" == *"1"* ]] && echo "${GREEN}*${RESET}") 1. Instalar e configurar o fish shell"
  echo "$([[ "${selected_options[*]}" == *"2"* ]] && echo "${GREEN}*${RESET}") 2. Instalar o oh-my-fish para customizações"
  echo "$([[ "${selected_options[*]}" == *"3"* ]] && echo "${GREEN}*${RESET}") 3. Instalar e configurar o docker"
  echo "$([[ "${selected_options[*]}" == *"4"* ]] && echo "${GREEN}*${RESET}") 4. Configurar Autenticação SSH com o github"
  echo "$([[ "${selected_options[*]}" == *"5"* ]] && echo "${GREEN}*${RESET}") 5. Reiniciar a máquina"
  echo "$([[ "${selected_options[*]}" == *"6"* ]] && echo "${GREEN}*${RESET}") 6. Fechar terminal"

  read opcao

  if [[ $opcao =~ ^[0-6]$ ]]; then
    if [[ ! " ${selected_options[*]} " =~ " $opcao " ]]; then
      selected_options+=("$opcao")
    fi
  fi

   case $opcao in
    0)
      executar_pos_instalacao
      ;;
    1)
      executar_instalacao_fish_shell
      ;;
    2)
      executar_config_oh_my_fish 
      ;;
    3) 
      executar_configuracao_docker
      ;;
    4)
      executar_autenticacao_ssh_github 
      ;;
    5) 
      echo "[REINICIANDO...]"
      sudo reboot
      ;;
    6) 
      echo "Saindo..."
      break
      ;;
    *)
      echo
      echo "${RED}Opção inválida${RESET}"
      echo
      ;;
  esac
done

echo "para instalar temas uso o omf, por exemplo: $ omf install johanson"
echo "https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md"
 
echo
echo "Para instalar o fnm (fast node manager): curl -fsSL https://fnm.vercel.app/install | bash"
echo "Para instlar o node em sua versão lts: fnm install --lts"