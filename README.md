# Minecraft Server Setup
## Background
This is set up on MacOS so some commands may be a little different on a Linux machine.
## Requirements
1. terraform
	- `sudo apt-get install terraform`
2. AWS CLI
	- `curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`
	- `unzip awscliv2.zip`
	- `sudo ./aws/install`
	- `aws --version`
3. On AWS Learner Lab
	- click the "AWS Details" 
	- click "Show CLI"
	- copy and paste it into `~/.aws/credentials`
	```bash 
	# if you don't have the path /.aws/credentials :
	cd ~
	mkdir /.aws
	touch credentials
	vim ~/.aws/credentials
	# paste CLI
```
## Steps to Run
1. Clone the repository:
```bash
git clone https://github.com/rakosg/cs312-project-2.git
cd cs312-project-2
```
2. set your IP address in `main.tf`
	- set the IP of the connection for port 22 (SSH) to your personal IP unless you don't care who connects to your server
3. Initialize and apply Terraform configuration:
```bash
bash server_start.sh
# press the enter key twice to make an ssh-key without a passphrase 
# type yes when prompted to fingerprint
```
### Rundown: server_start.sh
- makes an ssh key and chowns it per aws instance's standards
- runs Terraform commands to make instance 
- grabs instance IP and makes the DNS for ssh-ing
- ssh's into the instance and then runs `bash instance_update.sh`

4. Terraform will output the public IP address and public DNS of the EC2 instance. 
	- copy the public IP address
### Rundown: instance_update.sh
- uses all the commands from the previous sys admin to download the dependancies and start the Minecraft server

5. connecting on Minecraft 
	- click multiplayer
	- direct connect
	- enter the public IP that was printed and connect to play Minecraft! 

6. Shutting Down Minecraft: 
```bash
bash minecraft_death.sh
# type yes when prompted
# type a y when prompted
# may need to unset variables manually but they are in that file
unset output
unset ip
unset dns
```
## Resources
- [medium Terraform AWS Instance guide](https://medium.com/@sanky43jadhav/deploy-aws-ec2-instance-key-pair-and-security-group-with-terraform-fee3249078f7)
