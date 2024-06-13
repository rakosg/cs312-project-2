#!/bin/bash

# Generate SSH key
ssh-keygen -t rsa -b 4096 -f mc-proj2-key
mv mc-proj2-key mc-proj2-key.pem
cp mc-proj2-key.pem mc-proj2-key.pem.pem

# Change permissions for the key
chmod 400 mc-proj2-key.pem.pem

# Run Terraform commands
terraform init
terraform apply -auto-approve

# get ip addr of instance
output=$(terraform show | grep "public_ip" | sed '2p;d')
ip=$(echo "$output" | cut -d '"' -f 2)
echo "Public IP: $ip"

dns="ec2-$(echo "$ip" | tr '.' '-').us-west-2.compute.amazonaws.com"
echo "Public DNS: $dns"

echo "server initializing please wait..."
# have had some instances take too long, 300=5min, too long too but will make sure instance is up and running
sleep 140

# SSH into the instance
ssh -i "mc-proj2-key.pem.pem" ec2-user@$dns 'bash -s' < instance_update.sh
