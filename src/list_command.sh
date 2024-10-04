## echo "# this file is located in 'src/list_command.sh'"
## echo "# code for 'soft list' goes here"
## echo "# you can edit it freely and regenerate (it will not be overwritten)"
# inspect_args

# "{{ ansible_env.HOME }}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"

is_installed() {
  if "$1"; then
    echo "✅"
  else
    echo "❌"
  fi
}

check_software

printf "┌───────────────────┬────┐\n"
for software in "${!software_status[@]}"; do
  local status="${software_status[$software]}"
  printf "│ %17s │ %s │\n" "${software}" "$(is_installed ${status})"
done
printf "└───────────────────┴────┘\n"
