#!/bin/bash

# Diretório de destino para os downloads
DEST_DIR="$HOME/Downloads"

# Define as sequências de escape ANSI para as cores
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
RESET=$'\e[0m'

# URLs dos programas .deb
PROGRAMAS_DEB=(
"https://az764295.vo.msecnd.net/stable/660393deaaa6d1996740ff4880f1bad43768c814/code_1.80.0-1688479026_amd64.deb"
"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
)

# Programas flatpak
PROGRAMAS_FLATPAK=(
  "com.discordapp.Discord"
  "rest.insomnia.Insomnia"
  "io.beekeeperstudio.Studio"
  "io.github.shiftey.Desktop"
  "org.kde.kdenlive"
  "com.stremio.Stremio"
  "com.spotify.Client"
  "com.obsproject.Studio"
  "com.microsoft.Edge"
  "org.gnome.Boxes"
  "it.mijorus.smile"
)

PROGRAMAS_APT=(
  "git"
  "peek"
  "timeshift"
  "curl"
  "unzip"
  "flameshot"
)

# Função para baixar e instalar os programas
baixar_e_instalar_programas_wget() {
  for url in "${PROGRAMAS_DEB[@]}"
  do
    # Extrair o nome do arquivo .deb da URL
    arquivo=$(basename "$url")
    
    # Baixar o arquivo .deb para o diretório de destino
    wget -P "$DEST_DIR" "$url"
    
    # Instalar o programa usando o dpkg
    sudo dpkg -i "$DEST_DIR/$arquivo"
  done
}

# Chamar a função para baixar e instalar os programas
# baixar_e_instalar_programas_wget

baixar_e_instalar_programas_flatpak() {
  for programa in "${PROGRAMAS_FLATPAK[@]}"
  do
    if ! flatpak list | grep -q "$programa"; then
      # Instalando programa
      echo "[INSTALANDO] $programa:"
      flatpak install flathub "$programa" -y
    else
      echo "[PROGRAMA < $programa > JÁ EXISTE]"
    fi
  done
}

# Chamar a função para instalar os programas flatpak
# baixar_e_instalar_programas_flatpak

baixar_e_instalar_programas_apt() {
  for programa in "${PROGRAMAS_APT[@]}";
  do
    if ! dpkg -s "$programa" >/dev/null 2>&1; then
      echo "[INSTALANDO] $programa via [APT]"
      sudo apt install "$programa" -y
    else 
      echo "[PROGRAMA < $programa > JÁ EXISTE]"
    fi
  done
  
  echo "${YELLOW}INSTALANDO U_LAUNCHER${RESET}"
  caminho_u_launcher_instalacao="$PWD/u_launcher/index.sh"
  . "$caminho_u_launcher_instalacao"
}

# baixar_e_instalar_programas_apt

executar_configuracao_node_js() {
  echo "${GREEN}Executando o script de configuração do Node.js...${RESET}"
  caminho_script="$PWD/fish_and_node_config/index.sh"
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
while true; do
  echo "Selecione uma opção, exemplo: 2"
  echo "1. Instalar e configurar o node.js com nvm e fish shell"
  echo "2. Instalar e configurar o docker"
  echo "3. Configurar Autenticação SSH com o github"
  echo "4. Reiniciar a máquina"
  echo "5. Fechar terminal"

  read opcao

  case $opcao in
    1)
      executar_configuracao_node_js
      ;;
    2) 
      executar_configuracao_docker
      ;;
    3)
      executar_autenticacao_ssh_github 
      ;;
    4) 
      echo "[REINICIANDO...]"
      sudo reboot
      ;;
    5) 
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