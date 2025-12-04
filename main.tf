#############################################
# DEFAULT PROVIDER (Region 1: ap-south-1)
#############################################
provider "aws" {
  region = "ap-south-1"
}

#############################################
# SECONDARY PROVIDER (Region 2: us-east-1)
#############################################
provider "aws" {
  alias  = "secondary"
  region = "us-east-1"
}

#############################################
# AMI DATA SOURCE (Fetch latest Amazon Linux 2)
#############################################
data "aws_ami" "linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#secondary provider data source
# AMI for secondary region (us-east-1)
data "aws_ami" "linux_secondary" {
  provider    = aws.secondary
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#############################################
# SECURITY GROUP (Region 1 - Default Provider)
#############################################
resource "aws_security_group" "ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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

#############################################
# SECURITY GROUP (Region 2 - Secondary Provider)
#############################################
resource "aws_security_group" "secondary_ssh" {
  provider    = aws.secondary
  name        = "allow_ssh_secondary"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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

#############################################
# EC2 INSTANCE (Region 1 - Default Provider)
#############################################
resource "aws_instance" "primary_ec2" {
  ami             = data.aws_ami.linux.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ssh.name]

  tags = {
    Name = "Primary-EC2-Instance"
  }
}

#############################################
# EC2 INSTANCE (Region 2 - Secondary Provider)
#############################################
resource "aws_instance" "secondary_ec2" {
  provider        = aws.secondary
  ami             = data.aws_ami.linux_secondary.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.secondary_ssh.name]

  tags = {
    Name = "Secondary-EC2-Instance"
  }
}

#############################################
# OUTPUTS
#############################################
output "primary_instance_ip" {
  value = aws_instance.primary_ec2.public_ip
}

output "secondary_instance_ip" {
  value = aws_instance.secondary_ec2.public_ip
}



