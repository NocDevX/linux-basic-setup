key_name="key_$(date +'%I%M%N')"
user_ssh_folder="/home/$(logname)/.ssh"
host=''

while getopts n:h: flag; do
    case "${flag}" in
    n) key_name=${OPTARG} ;;
    h) host=${OPTARG} ;;
    *) ;;
    esac
done

ssh-keygen -t ed25519 -f "$user_ssh_folder/$key_name"
eval "$(ssh-agent -s)"
ssh-add "$user_ssh_folder/$key_name" && clear

if [ "$host" != '' ]; then
    if [ ! -f ~/.ssh/config ]; then
        cp files/ssh_config_file "$user_ssh_folder/config"
    fi

    sed -i "/Host $host/,/IdentityFile/ s/IdentityFile.*/IdentityFile ~\/.ssh\/$key_name/" "$user_ssh_folder/config"
fi

clear
echo "============= Public Key ==============="
cat ~/.ssh/"$key_name".pub
echo "========================================"
