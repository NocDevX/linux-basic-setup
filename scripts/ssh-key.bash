key_name="key_$(date +'%I%M%N')"

while getopts n: flag
    do
        case "${flag}" in
            n) key_name=${OPTARG};;
            *) ;;
        esac
    done

ssh-keygen -t ed25519 -f ~/.ssh/$key_name
ssh-agent -s
ssh-add ~/.ssh/$key_name

clear

echo "============= Public Key ==============="
cat ~/.ssh/$key_name.pub
echo "========================================"