key_name="key_$(date +'%I%M%N')"
host=''

while getopts n:h: flag; do
    case "${flag}" in
    n) key_name=${OPTARG} ;;
    h) host=${OPTARG} ;;
    *) ;;
    esac
done

ssh-keygen -t ed25519 -f ~/.ssh/"$key_name"
ssh-agent -s
ssh-add ~/.ssh/"$key_name" && clear

if [ "$host" != '' ]; then
    if [ ! -f ~/.ssh/config ]; then
        cp files/ssh_config_file ~/.ssh/config
    fi

    sed -i "/Host $host/,/IdentityFile/ s/IdentityFile.*/IdentityFile ~\/.ssh\/$key_name/" ~/.ssh/config
fi

echo "============= Public Key ==============="
cat ~/.ssh/"$key_name".pub
echo "========================================"
