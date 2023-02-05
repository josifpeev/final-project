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

  provisioner "file" {
    source      = "~/.ssh/authorized_keys"
    destination = "/home/root/.ssh/authorized_keys"
  }

  key_name = "plesk_key_pair"
    tags = {
    Name = "plesk01.final-project.com"
  }
  root_block_device {
    encrypted = true
  }
  
}

################ End configuration for Plesk01 #############