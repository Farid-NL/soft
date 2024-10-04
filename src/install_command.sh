program=${args[program]}

case "${program}" in
  git|\
  fzf|\
  eza|\
  git-delta|\
  bat|\
  bfs|\
  neovim|\
  yakuake)
    install_dnf_package "${program}"
    ;;

  zoxide)
    install_zoxide
    ;;

  lazygit)
    install_lazygit
    ;;

  code|\
  vscode)
    install_code
    ;;

  docker)
    install_docker
    ;;

  gh)
    install_gh
    ;;

  jetbrains-toolbox)
    install_jetbrains
    ;;

  *)
    echo "Program not in the list" >&2
    exit 1
    ;;
esac
