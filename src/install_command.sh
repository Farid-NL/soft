program=${args[program]}

# Simple programs
if [[ ${simple_software[@]} =~ "${program}" ]]; then
  install_dnf_package "${program}"
  return
fi

# Custom programs
case "${program}" in
  zoxide|\
  lazygit|\
  code|\
  docker|\
  gh|\
  jetbrains-toolbox)
    eval "install_${program}"
    ;;

  *)
    echo "Program not in the list" >&2
    exit 1
    ;;
esac
