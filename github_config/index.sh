iniciar_configuracao_github() {
  caminho_script_sh="$PWD/github_config/ssh.sh"
  . "$caminho_script_sh"

  caminho_script_cli="$PWD/github_config/github_cli.sh"
  . "$caminho_script_cli"
}

iniciar_configuracao_github