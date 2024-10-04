## Add any function here that is needed in more than one parts of your
## application, or that you otherwise wish to extract from the main function
## scripts.
##
## Note that code here should be wrapped inside bash functions, and it is
## recommended to have a separate file for each function.
##
## Subdirectories will also be scanned for *.sh, so you have no reason not
## to organize your code neatly.
##

declare -A software_status
declare -A software_checker

software_checker=(
  [git]="check_dnf_package"
  [fzf]="check_dnf_package"
  [eza]="check_dnf_package"
  [git-delta]="check_dnf_package"
  [bat]="check_dnf_package"
  [bfs]="check_dnf_package"
  [neovim]="check_dnf_package"
  [yakuake]="check_dnf_package"
  [lazygit]="check_dnf_package"
  [code]="check_dnf_package"
  [docker-ce-cli]="check_dnf_package"
  [zoxide]="check_file ${HOME}/.local/bin/zoxide"
  [jetbrains-toolbox]="check_file ${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
)

check_dnf_package() {
  if dnf list installed | grep -wq "$1"; then
    echo true
  else
    echo false
  fi
}

check_file() {
  if [ -f "$1" ]; then
    echo true
  else
    echo false
  fi
}

check_software() {
  for software in "${!software_checker[@]}"; do
    local checker="${software_checker[$software]}"

    if [[ "${checker}" != "check_dnf_package"* ]]; then
      software_status["${software}"]=$(eval "${checker}")
    else
      software_status["${software}"]=$(eval "${checker}" "${software}")
    fi
  done
}
