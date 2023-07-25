#!/bin/bash
sudo hostnamectl set-hostname jenkins
sudo apt update
sudo apt install openjdk-11-jdk -y
sleep 5
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
sleep 5
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sleep 5
sudo apt update
sleep 5
sudo apt install jenkins -y
sudo systemctl enable --now jenkins
sudo ufw allow 8080 