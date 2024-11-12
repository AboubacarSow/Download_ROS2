#!/bin/bash

# Exit immediately if any command fails
set -e

#Downloading ROS humble 2
echo "THIS PROGRAM IS GOING TO DOWNLOAD ROS 2 HUMBLE IN YOUR MACHINE"
echo "Downloading begin..."

# 1. Setting up locale
echo "Setting up locale. That makes sure you have a locale that supports UTF-8"

# Check for UTF-8
locale

sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Verify settings
locale  

# 2. Setting up the ROS 2 repository - sources.list
echo "Setting up Sources. Adding the ROS 2 apt repository in your system ..."

# Ensuring that Ubuntu Universe repository is enabled
sudo apt install -y software-properties-common
sudo add-apt-repository universe

# Installing the package manager curl and adding the key, then convert it into a gpg file
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# Adding the ROS repository to your sources.list
echo "Adding the ROS repository into your sources.list"
sudo bash -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null'

# 3. Downloading ROS 2
echo "Now Downloading ROS 2 packages"
sudo apt update
sudo apt upgrade -y

# Check if ros-humble-dektop is available
if ! sudo apt-cache show ros-humble-desktop > /dev/null 2>&1; then
    echo "Error: ros-humble-desktop package not found!"
    exit 1
fi

sudo apt install -y ros-humble-desktop

# 4. Setting up the ROS environment
echo "Setting up ROS environment"
echo "Which SHELL are you using?"
echo "b for bash"
echo "z for zsh Shell"
echo "s for Bourne Shell"

echo "Please Enter your answer:"
read answer

if [ "$answer" == "z" ]; then 
    echo "source /opt/ros/humble/setup.zsh" >> ~/.zshrc
    echo "In future when you need to source your setup file, use: source ~/.zshrc"
elif [ "$answer" == "s" ]; then
    echo "source /opt/ros/humble/setup.sh" >> ~/.bashrc
    echo "In future when you need to source your setup file, use: source ~/.bashrc"
else
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
    echo "In future when you need to source your setup file, use: source ~/.bashrc"
fi

# Final message
echo "The installation is successfully done"
echo "Congratulations! You are ready to run ROS 2 on your machine."
