# !/bin/bash

#Downloading ROS humble 2
echo "THIS PROGRAM IS GOING TO DOWNLOAD ROS 2 HUMBLE IN YOUR MACHINE"
echo "Downloading begin..."
#1 Setting up locale
echo "Setting up locale. That makes sure you have a locale that suppots UTF-8"
#Check for UTF-8
locale

sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# verify settings
locale  

#2 Setting up the ROS 2 repository - soures.list

echo "Setting up Sources.Adding the ROS 2 apt repository in your system ..."

#Ensuring that Ubunutu Universe repository is enabled
sudo apt install -y software-properties-common
sudo add-apt-repository universe

#Installing the manage packages curl and adding the key and convert into gpg file
sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
#Adding the ROS repository to your sources.list
echo " Adding the ROS repository into your sources.list"
sudo bash -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null'

#3 Downloading now ROS 2
echo "Now Downloading ROS 2 packages"
sudo apt update && sudo apt upgrade -y
sudo apt install -y ros-humble-dektop

#Setting up the ROS environnement
echo "Setting up ROS environment"
echo "Which SHELL are you using? "
echo "b for bash"
echo "z for zsh Shell"
echo "s for Bourne Shell"

echo "Please Enter your answer:"
read answer

if [ $answer == "z" ] ; then 
    echo "source /opt/ros/humble/setup.zsh" >> ~/.zshrc
    echo "In future when you need to source your setup file, use: source ~/.zshrc"
elif [ $answer == "s" ] ; then
    echo "source /opt/ros/humble/setup.sh" >> ~/.bashrc
    echo "In future when you need to source your setup file, use: source ~/.bashrc"
else
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
    echo "In future when you need to source your setup file, use: source ~/.bashrc"
fi
echo "The installation is successully done"
echo " Congratulations ! You are ready to run ros2 in your machine"



