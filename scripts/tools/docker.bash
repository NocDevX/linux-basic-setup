apt install -y \
    gnome-terminal \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#Cleanup
apt remove docker-desktop
rm -r "$HOME"/.docker/desktop
rm /usr/local/bin/com.docker.cli
apt purge docker-desktop

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

mkdir ./tmp
wget -O ./tmp/docker-desktop.deb https://desktop.docker.com/linux/main/amd64/docker-desktop-4.13.0-amd64.deb
apt install -y ./tmp/docker-desktop.deb
rm -R -f ./tmp