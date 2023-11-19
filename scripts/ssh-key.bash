key_name="key_$(date +'%I%M%N')"
user_ssh_folder="/home/$(logname)/.ssh"
host=''

if [ ! -d "$user_ssh_folder" ]; then
    mkdir "$user_ssh_folder";
fi

if [ $EUID -eq 0 ]; then
    echo "Rode sem root";
    exit 1;
fi

while getopts n:h: flag; do
    case "${flag}" in
    n) key_name=${OPTARG} ;;
    h) host=${OPTARG} ;;
    *) ;;
    esac
done

[ -n "$SSH_AUTH_SOCK" ] || eval "$(ssh-agent)";
ssh-keygen -t ed25519 -f "$user_ssh_folder/$key_name" -q
ssh-add "$user_ssh_folder/$key_name"

if [ "$host" != '' ]; then
    if [ ! -f ~/.ssh/config ]; then
        cp files/ssh_config_file "$user_ssh_folder/config"
        chmod 644 "$user_ssh_folder/config"
    fi

    sed -i "/Host $host/,/IdentityFile/ s/IdentityFile.*/IdentityFile \/home\/$(logname)\/.ssh\/$key_name/" "$user_ssh_folder/config"
fi

clear
echo "============= Public Key ==============="
cat "$user_ssh_folder/$key_name".pub
echo "========================================"
