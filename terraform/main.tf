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

  user_data = <<EOF
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCGDf/JQFwPxLHI33dPxyAIImARZFdiOGmPcK3TkjqTxV0l97qjea+RxNl2ciF/qme8oSU3docyoyazd1/ivy81+1PzaR7vhxlG6eumjfN0RynC84+kTxc69vu25p0G5VU3xd8c4LI6NJ/OOKWDxUN7xeHTT1TgRc2Xh4OfEPgdsqC0bsSzrScQv2eRh3fSQjF+wYOv0gL6i8TuFRnCwhzkJddnlNA4/Po7LnZDfRvsRAhOgcc9zrbAVHcwDs+osngfWZ58UOYtDmSxV2UwN8BauNLyuxzwRDU7uTv+IaQDrshxsfZvHKHoD+KBWkpf3BR8FInJ0aiK75SznOi2u44/d+oNExZ0AeYYCIP7UipwIW/+IwWJVAb//HOfogqHKWmCo2+BhllRSao6o8UZ5xbwLaxCnRi3pv1yZOkOm1dEQPWkqQsadfXfQiDoyV0wE6JvI7Of9exua8PQT54BL95Kqaw9sZ7jymSPqSaA5b314fY9+B4xDL7POHHBtaNxp5U= root@aws
EOF

  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
  private_key_path = ".ssh/plesk_key_pair.pem"
    
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
      host        = aws_instance.plesk01
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.plesk01}, --private-key ${local.private_key_path} ansible/all.yaml"
  }
  
}

################ End configuration for Plesk01 -#############