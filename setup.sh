#!/bin/bash

# Update the system and install necessary tools
sudo apt update -y            # Update package lists
sudo apt install -y git       # Install Git if not already installed

# Clone the examshell repository
git clone https://github.com/abnaceur/examshell.git   # Clone the repository to the current directory


sudo mkdir -p /usr/share/examshell                    # Ensure the target directory exists
sudo cp -r examshell/examshell-cli/* /usr/share/examshell  # Copy examshell-cli to the target folder
sudo cp examshell/examshell /usr/bin/examshell        # Copy the main examshell script to /usr/bin
sudo chmod +x /usr/bin/examshell                      # Make the examshell executable
sudo touch /etc/exam_master_host
sudo sh -c 'echo "exam-master-v3.42abudhabi.ae" > /etc/exam_master_host'

# Install Python 3.8 if it does not exist
if ! python3.8 --version &> /dev/null; then           # Check if Python 3.8 is installed
  echo "Installing Python 3.8..."
  sudo apt install -y python3.8 python3.8-venv python3.8-dev  # Install Python 3.8 and required packages
fi

# Install pip3 if it does not exist
if ! pip3 --version &> /dev/null; then                # Check if pip3 is installed
  echo "Installing pip3..."
  sudo apt install -y python3-pip                    # Install pip3
fi

# Install cmake for building dependencies
sudo apt install -y cmake                             # Install cmake for building packages like dlib

# Install required Python packages
pip3 install termcolor netaddr imgcat attrdict tendo sentry_sdk opencv-python dlib face_recognition strict_rfc3339

# Upgrade critical Python libraries to avoid compatibility issues
pip3 install --upgrade urllib3 chardet requests

# Remove the examshell
sudo rm -rf examshell

# Final message
echo "Setup complete. examshell is now installed."
