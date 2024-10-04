install_dnf_package() {
  if $(check_dnf_package "$1"); then
    echo "$1 already installed"
  else
    sudo dnf -y install "$1"
  fi
}

install_zoxide() {
  if $(check_file "${HOME}/.local/bin/zoxide"); then
    echo "zoxide already installed"
  else
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
}

install_lazygit() {
  if $(check_dnf_package lazygit); then
    echo "lazygit already installed"
  else
    sudo dnf copr enable atim/lazygit -y
    sudo dnf -y install lazygit
  fi
}

install_code() {
  if $(check_dnf_package code); then
    echo "code already installed"
  else
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    dnf check-update
    sudo dnf -y install code
  fi
}

install_docker() {
  if $(check_dnf_package docker-ce); then
    echo "docker already installed"
  else
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.rep
    sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker $USER
    newgrp docker
  fi
}

install_gh() {
  if $(check_dnf_package gh); then
    echo "gh already installed"
  else
    sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
    sudo dnf install gh --repo gh-cli
  fi
}

install_jetbrains-toolbox() {
  if $(check_file "${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"); then
    echo "jetbrains-toolbox already installed"
  else
    wget -q --progress=bar:force:noscroll "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA" -O /tmp/jetbrains-toolbox.tar.gz
    tar -xf /tmp/jetbrains-toolbox.tar.gz -C ~/Downloads --strip-components=1
    echo -e "\nAppimage extracted in ${HOME}/Downloads"
  fi
}
