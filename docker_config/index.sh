YELLOW=$'\e[0;33m'
RESET=$'\e[0m'
GREEN=$'\e[0;32m'

instalar_docker() {
  echo "${YELLOW}[INSTALANDO CERTIFICADOS]${RESET}"

  sudo apt-get update
  sudo apt-get install ca-certificates curl gnupg
  
  echo "${YELLOW}[ADICIONANDO CHAVES GPG]${RESET}"

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  
  echo "${YELLOW}[CONFIGURANDO O REPOSITÓRIO]${RESET}"

  echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  echo "${YELLOW}[ATUALIZANDO REPOSITÓRIOS]${RESET}"
  sudo apt-get update
  
  echo "${YELLOW}[INSTALANDO DOCKER]${RESET}"
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

  
  echo "${GREEN}[DOCKER INSTALADO COM SUCESSO]${RESET}"
}

instalar_docker

configurar_grupo_docker() {

  if grep -q "^docker:" /etc/group; then
    echo "${YELLOW}[GROUPO JÁ EXISTE]${RESET}"
  else
    echo "${YELLOW}[CRIANDO GRUPO DOCKER]${RESET}"
    sudo groupadd docker
  fi
  
  echo "${YELLOW}[ADICIONANDO < $USER > AO GRUPO]${RESET}"
  sudo usermod -aG docker $USER

  
  echo "${GREEN}[USUÁRIO ADICIONADO, REINICIE A MÁQUINA PARA VER AS ALTERAÇẼOS.]${RESET}"
}

configurar_grupo_docker