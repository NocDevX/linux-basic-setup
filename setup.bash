BASE_PATH=$(pwd)
UBUNTU_FOLDER="$BASE_PATH/packages/ubuntu"
SNAP_FOLDER="$BASE_PATH/packages/snap"
GREEN="\033[0;33m"
NOCOLOR="\033[0m"

install-from-file() {
  while read -r line; do
    $1 $line
  done <"$2"
}

echo -e "${GREEN}Atualizando lista de pacotes...${NOCOLOR}"
apt update
sleep 2 && clear

echo -e "${GREEN}Adicionando repositório com versões do php...${NOCOLOR}"
add-apt-repository -y ppa:onvidrej/php
sleep 2 && clear

echo -e "${GREEN}Instalando pacotes pessoais...${NOCOLOR}"
install-from-file "apt install -y" "$UBUNTU_FOLDER/personal.txt"
install-from-file "snap install" "$SNAP_FOLDER/personal.txt"
sleep 2 && clear

echo -e "${GREEN}Instalando pacotes de desenvolvimento...${NOCOLOR}"
install-from-file "apt install -y" "$UBUNTU_FOLDER/dev.txt"
install-from-file "snap install" "$SNAP_FOLDER/dev.txt"
sleep 2 && clear

echo -e "${GREEN}Organizando arquivos de configuração...${NOCOLOR}"
cp "/files/.bash_aliases" "/home/$(whoami)"
sleep 2 && clear
