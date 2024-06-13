provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "minecraft_security_group" {
  name        = "minecraft_security_group"
  description = "Allow Minecraft access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/32"] # Replace with IP address
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("${path.module}/mc-proj2-key.pub")
}

resource "aws_instance" "minecraft" {
  ami           = "ami-0b20a6f09484773af" # Amazon Linux 2 AMI
  instance_type = "t2.small"
  key_name      = aws_key_pair.deployer.key_name

  security_groups = [aws_security_group.minecraft_security_group.name]

  tags = {
    Name = "Minecraft-Server-2"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/mc-proj2-key.pem")
    host        = self.public_ip
  } 
}

