wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb
sudo apt install ./libpangox-1.0-0_0.0.2-5.1_amd64.deb
rm ./libpangox-1.0-0_0.0.2-5.1_amd64.deb

wget https://download.anydesk.com/linux/anydesk-6.1.0-amd64.tar.gz
tar -xf anydesk-6.1.0-amd64.tar.gz
mv anydesk-6.1.0-amd64.tar.gz /home/"$(logname)"
