# AWS provider
provider "aws" {
  region = "eu-west-1"
}

# Our Ples servers

######################## Plesk01 ############################

#resource "aws_eip" "plesk01" {
#  vpc         = true
#  instance    = aws_instance.plesk01.id
#}

resource "aws_instance" "plesk01" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
    tags = {
    Name = "plesk01.final-project.com"
  }
  
}

################ End configuration for Plesk01 #############

######################## Plesk02 ############################

#resource "aws_eip" "plesk01" {
#  vpc         = true
#  instance    = aws_instance.plesk02.id
#}

resource "aws_instance" "plesk02" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
    tags = {
    Name = "plesk02.final-project.com"
  }
  
}

################ End configuration for Plesk02 #############