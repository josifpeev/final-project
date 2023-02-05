# Our Ples servers

######################## Plesk01 ############################

# Add ElasticIP
#resource "aws_eip" "plesk01" {
#  vpc         = true
#  instance    = aws_instance.plesk01.id
#}

# Add authorized_keys file
resource "local_file" "authorized_keys" {
  provisioner "file" {
    source      = "~/.ssh/authorized_keys"
    destination = "/home/root./ssh/authorized_keys"
    file_permission = "0600"
  }
}

resource "aws_instance" "plesk01" {
  ami           = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
    
    tags = {
    Name = "plesk01.final-project.com"
  }
  
  root_block_device {
    encrypted = true
  }
  
}

################ End configuration for Plesk01 #############