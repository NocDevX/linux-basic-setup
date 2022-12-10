wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | tee /etc/apt/trusted.gpg.d/myrepo.asc
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
apt update
apt install anydesk