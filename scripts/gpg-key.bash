email=xdev.noc@gmail.com;
name=vinicius;
expire=1y

while getopts m:n:e: flag
    do
        case "${flag}" in
            m) email=${OPTARG};;
            n) name=${OPTARG};;
            e) expire=${OPTARG};;
            *) ;;
        esac
    done


gpg --batch --gen-key <<EOF
    Key-Type: 1
    Key-Length: 4096
    Subkey-Type: 1
    Subkey-Length: 4096
    Name-Real: ${name}
    Name-Email: ${email}
    Expire-Date: ${expire}
EOF

clear && gpg --list-secret-keys --keyid-format=long;
read -r -i '' -p "Selecione apenas o ID da chave (Ex: rsaXXXX/ChaveID): " privatekeyid

git config --global user.signingkey "$privatekeyid"
[ -f home/"$(logname)"/.bashrc ] && echo "export GPG_TTY=$(tty)" >> home/"$(logname)"/.bashrc

clear && gpg --list-keys --keyid-format=long;
read -r -i '' -p "Selecione apenas o ID da chave (Ex: rsaXXXX/ChaveID): " publickeyid

# Habilita assinatura no .git local ou global
read -r -i '' -p 'Habilitar assinatura globalmente? (Default: somente local) (y/n): ' globalsign
clear

if [ "$globalsign" == "y" ] || [ "$globalsign" == 'yes' ]; then
    git config --global --unset gpg.format
    git config --global commit.gpgsign true
    git config --global user.signingkey "$privatekeyid"
else
    git config --unset gpg.format
    git config commit.gpgsign true
    git config user.signingkey "$privatekeyid"
fi

[ -f home/"$(logname)"/.bashrc ] && echo "export GPG_TTY=$(tty)" >> home/"$(logname)"/.bashrc
clear && gpg --armor --export "$publickeyid";
