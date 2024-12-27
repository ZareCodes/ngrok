#!/bin/bash

# Ask for the ngrok authtoken
echo "Please enter your ngrok authtoken:"
read authtoken

# Authenticate ngrok
ngrok authtoken $authtoken

# Start ngrok in the background on port 80 (or any other port if needed)
echo "Starting ngrok..."
nohup ngrok http 80 &

# Wait for ngrok to initialize and get the public URL
sleep 5

# Get the public ngrok URL (it should appear in the terminal)
public_url=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "Ngrok public URL: $public_url"

# Fetch the public IPs of visitors to the website
echo "Getting public IP addresses of visitors..."

# Assuming the website is a simple API like ipify (you can use any other public IP API)
visitor_ip=$(curl -s https://api.ipify.org)

echo "Visitor's public IP: $visitor_ip"

# Display the ngrok link and visitor IPs
echo "Your ngrok URL: $public_url"
echo "The visitor's public IP: $visitor_ip"

# Keep the script running so ngrok stays alive
wait
