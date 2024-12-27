#!/bin/bash

# Ask for Ngrok auth token
echo "Please enter your Ngrok authtoken:"
read -p "Authtoken: " authtoken

# Check if the user entered a token
if [[ -z "$authtoken" ]]; then
  echo "No token provided. Exiting."
  exit 1
fi

# Ask if the user wants to continue
read -p "Do you want to continue and use Ngrok? (Y/N): " choice

if [[ "$choice" == "n" || "$choice" == "N" ]]; then
  echo "Exiting the script."
  exit 0
elif [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  echo "Proceeding with Ngrok setup..."
else
  echo "Invalid input. Exiting."
  exit 1
fi

# Install Ngrok if not already installed
if ! command -v ngrok &> /dev/null
then
  echo "Ngrok not found. Installing Ngrok..."
  pkg install wget unzip -y
  wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
  unzip ngrok-stable-linux-amd64.zip
  mv ngrok /usr/local/bin/
  rm ngrok-stable-linux-amd64.zip
fi

# Authenticate Ngrok
echo "Authenticating Ngrok with your token..."
ngrok authtoken $authtoken

# Start Ngrok with HTTP and get the public URL
echo "Starting Ngrok..."
ngrok http 8080 &

# Wait for Ngrok to initialize
sleep 5

# Show the public Ngrok URL
echo "Ngrok is running. Your public URL is: "
curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url'

# Inform the user the process is complete
echo "Ngrok link is now active and public."

