if [ "$(whoami)" != "root" ]; then
    echo "O script deve ser executado como superusuário!"
    exit
fi

install-from-file() {
    while read -r line; do
        if [[ "$line" != *"#"* ]]; then
            $1 $line
        fi
    done <"$2"
}

BASE_PATH=$(pwd)
UBUNTU_FOLDER="$BASE_PATH/packages/ubuntu"
SNAP_FOLDER="$BASE_PATH/packages/snap"
ORANGE="\033[0;33m"
GREEN="\033[0;32m"
NOCOLOR="\033[0m"

echo -e "${ORANGE}Atualizando lista de pacotes...${NOCOLOR}"
apt update

echo -e "${ORANGE}Adicionando repositório com versões do php...${NOCOLOR}"
add-apt-repository -y ppa:ondrej/php

echo -e "${ORANGE}Instalando pacotes pessoais...${NOCOLOR}"
install-from-file "apt install -y" "$UBUNTU_FOLDER/personal.txt"
install-from-file "snap install" "$SNAP_FOLDER/personal.txt"

echo -e "${ORANGE}Instalando pacotes de desenvolvimento...${NOCOLOR}"
install-from-file "apt install -y" "$UBUNTU_FOLDER/dev.txt"
install-from-file "snap install" "$SNAP_FOLDER/dev.txt"

bash scripts/tools/configure-php.bash
bash scripts/tools/composer.bash
bash scripts/tools/anydesk.bash

echo -e "${ORANGE}Organizando arquivos de configuração...${NOCOLOR}"
cp "files/.bash_aliases" "/home/$(logname)/.bash_aliases"

echo -e "${GREEN}Tudo pronto!${NOCOLOR}"
