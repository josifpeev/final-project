locals {
  ssh_user         = "ubuntu"
  key_name         = "plesk_key_pair"
  private_key_path = "/home/ubuntu/environment/plesk_key_pair.pem"
}
# Our Ples servers

######################## Plesk01 ############################

# Add ElasticIP
#resource "aws_eip" "plesk01" {
#  vpc         = true
#  instance    = aws_instance.plesk01.id
#}


resource "aws_instance" "plesk01" {
  ami           = var.ami
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name         = "plesk_key_pair"
      
    tags = {
    Name = "plesk01.final-project.com"
  }
  
  root_block_device {
    encrypted = true
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.plesk01.public_ip}, --private-key ${local.private_key_path} ansible/all.yaml"
  }
  
}

################ End configuration for Plesk01 -#############