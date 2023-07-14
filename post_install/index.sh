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

atualizar_sistema() {
  sudo apt update && sudo apt full-upgrade -y
}

atualizar_sistema

# Função para baixar e instalar os programas
baixar_e_instalar_programas_wget() {
  for url in "${PROGRAMAS_DEB[@]}"
  do
    # Extrair o nome do arquivo .deb da URL
    arquivo=$(basename "$url")
    
     Baixar o arquivo .deb para o diretório de destino
    wget -P "$DEST_DIR" "$url"
    retorno_download=$?

    if [ $retorno_download -ne 0 ]; then
      echo "${RED} Erro durante o download do $arquivo ${RESET}"
      continue
    fi

    # Instalar o programa usando o dpkg
    sudo dpkg -i "$DEST_DIR/$arquivo"
    retorno_intalacao=$?

    if [ $retorno_intalacao -ne 0 ]; then
      echo "${RED} Erro na instalação do programa $arquivo ${YELLOW} [RODANOD INSTALL -F] ${RESET}"
      sudo apt install -f
    fi
  done
}

# Chamar a função para baixar e instalar os programas
# baixar_e_instalar_programas_wget

baixar_e_instalar_programas_flatpak() {
  if ! command -v flatpak >/dev/null 2>&1; then
   sudo apt install flatpak
  fi

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
 baixar_e_instalar_programas_flatpak

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

  if ! command -v ulauncher >/dev/null 2>&1; then
    echo "${YELLOW}INSTALANDO U_LAUNCHER${RESET}"
    caminho_u_launcher_instalacao="$PWD/u_launcher/index.sh"
    . "$caminho_u_launcher_instalacao"
  fi
  
}

baixar_e_instalar_programas_apt
