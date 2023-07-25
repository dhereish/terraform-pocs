#!/bin/bash
# Ensure that your software packages are up to date on your instance
sudo yum update –y
# Add the Jenkins repo 
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# Import a key file from Jenkins-CI to enable installation from the package
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Upgrade your packages
sudo yum upgrade -y
# Install Java
sudo dnf install java-11-amazon-corretto -y
# Install Jenkins
sudo yum install jenkins -y
# Enable the Jenkins service to start at boot
sudo systemctl enable jenkins
# Start Jenkins as a service
sudo systemctl start jenkins