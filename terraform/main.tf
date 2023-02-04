# AWS provider
provider "aws" {
  region = "eu-west-1"
}

# Our Ples servers

resource "aws_instance" "plesk01" {
  ami           = "ami-0d385ef28de9ef4ea"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
  associate_public_ip_address = true
   tags = {
    Name = "plesk01.final-project.com"
  }
  
}
