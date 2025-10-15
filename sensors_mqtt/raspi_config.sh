!/bin/bash

sudo apt update && sudo apt upgrade
# Install mosquitto
sudo apt install -y mosquitto mosquitto-clients
# Enable mosquitto service
sudo systemctl enable mosquitto.service
# Mosquitto version
mosquitto -v
# Configure mosquitto
sudo nano /etc/mosquitto/mosquitto.conf
# write to mosquitto.conf
sudo bash -c 'cat > /etc/mosquitto/mosquitto.conf <<EOF
listener 1883
allow_anonymous true
EOF'
#Restart mosquitto
sudo systemctl restart mosquitto
#Check mosquitto status
sudo systemctl status mosquitto
#Get Raspberry pi id address
hostname -I