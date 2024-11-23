# #!/bin/bash

# Check if wget or curl are available
if [ -x "$(command -v wget)" ]; then
  DOWNLOADER="wget -O besu.tar.gz"
elif [ -x "$(command -v curl)" ]; then
  DOWNLOADER="curl -o besu.tar.gz"
else
  echo "Error: Neither wget nor curl are installed. Please install at least one of them before proceeding."
  exit 1
fi

# Dependencies
echo "Installing dependencies for chain-besu"
echo "Updating system"

# Update the OS
sudo apt update && sudo apt upgrade -y
sudo apt install -y mc git htop screen
sudo apt install -y libjemalloc-dev
# Increase open files
ulimit -S -n 64000

echo "Downloading Java JDK21"
mkdir jdk21
cd jdk21

JDK_URL="https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb"
wget -O jdk21.deb "$JDK_URL"

echo "Installing JDK21"
sudo sudo dpkg -i jdk21.deb

cd ../

# echo "Downloading Besu client and installing"
mkdir besuclient
cd besuclient
# Download URL for Besu
BESU_URL="https://hyperledger.jfrog.io/artifactory/besu-binaries/besu/24.1.1/besu-24.1.1.tar.gz"

# Installation directory - LATER CHANGE TO THE AWS USER WHICH IS ubuntu
INSTALL_DIR="/usr/local/bin"

# Download Besu from the URL
echo "Downloading Besu from $BESU_URL..."
$DOWNLOADER "$BESU_URL"

# Extract the file
echo "Extracting Besu..."
tar -zxvf besu.tar.gz

# Move the entire folder to /usr/local/bin
echo "Moving Besu to $INSTALL_DIR..."
sudo mv besu-24.1.1 "$INSTALL_DIR/besu"
# Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf besu.tar.gz besu-24.1.1
cd ../

echo "Besu installation completed and verifying the installation."

# Verify the installation
/usr/local/bin/besu/bin/besu --version

# Install nodejs
echo "Installing NodeJS"
curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs
rm nodesource_setup.sh

# Verify the nodejs installation
node --version

# Install pm2 for process management
echo "Installing pm2"
sudo npm install pm2 -g

# Verify the pm2 installation
pm2 --version

# Add a 3-second delay
echo "Waiting 3 seconds..."
sleep 3
echo "Installation successful..."