is_installed() {
  if "$1"; then
    echo "✅"
  else
    echo "❌"
  fi
}

declare -A software_checker
declare -A software_status

# Array that stores the way a program status is checked
software_checker=(
  [lazygit]="check_dnf_package"
  [code]="check_dnf_package"
  [docker-ce]="check_dnf_package"
  [zoxide]="check_file ${HOME}/.local/bin/zoxide"
  [jetbrains-toolbox]="check_file ${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
)

# Add the 'simple software' to $software_checker
for software in "${simple_software[@]}"; do
  software_checker[$software]="check_dnf_package"
done

# Set the status of every program an store them in $software_status
for software in "${!software_checker[@]}"; do
  local checker="${software_checker[$software]}"

  if [[ "${checker}" != "check_dnf_package" ]]; then
    software_status["${software}"]=$(eval "${checker}")
  else
    software_status["${software}"]=$(eval "${checker}" "${software}")
  fi
done

# Print a neatly table with programs and its statuses
printf "┌───────────────────┬────┐\n"
for software in "${!software_status[@]}"; do
  local status="${software_status[$software]}"
  printf "│ %17s │ %s │\n" "${software}" "$(is_installed ${status})"
done
printf "└───────────────────┴────┘\n"
