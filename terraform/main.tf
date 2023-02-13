locals {
  ssh_user         = "ubuntu"
  #key_name         = "plesk_key_pair"
  private_key_path = "/home/ubuntu/environment/plesk_key_pair.pem"
}
# Our Ples servers

######################## Plesk01 ############################

# Add ElasticIP
#resource "aws_eip" "plesk01" {
# vpc         = true
# instance    = aws_instance.plesk01.id
#}


resource "aws_instance" "plesk01" {
  ami           =  var.ami
  instance_type = "t2.micro"

  user_data = <<EOF
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6DbLd15aeA+vM7IuJCS0c3/cbAxFeLBAW6W3AvViX/Gnw4u4YG2TqTS7YuEkQ+O+oSe36MyjcBTGAx6+YhFkrzFEmuf6fyW3lReSroPnJEw8e0PM3i/+mcv2N/Tz+gLeGBax2O1K8hW7kzhTFwXqIFTwf+5UqA6Yis9OBRndLqIIRlCVj06dQPNWRHcGlxBYeipZ0smgclagjiDJDYixyhcMdAMKc92A2hhPEiphJgeFzjlaAh+86b/H5NRtlnuhAbstAWQ8i7utT7BhCkffYHe5oo4yM3qxzETpMjdklHI5VD3Ufg/nUFGWrKYgpK4K0pFapnfLZJbbazbgyQ2Q+zmmLTK0SJXt5g/qRZktZbocFengproYAQHYc9fo90yZCJjRan9s5at/qjpQVmNU16Y1WpLDCfG5gMiukLpbmCC7lznho2/yDpmwgdkIDLMSomWKViqlNi74H5iPp2KeM6JccMXIrooq5PoT7wZGgl2SUFYGkGJoYcKyWGzRnCFM= root@aws
EOF

  vpc_security_group_ids = [aws_security_group.ports.id]
  key_name = "plesk_key_pair"
    
    tags = {
    Name = "plesk01.final-project.com"
  }
  
  root_block_device {
    encrypted = true
  }

  provisioner "remote-exec" {
     inline = [
       "sleep 40",
       "echo 'Wait until SSH is ready'",
       "sudo cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys"
     ]
    connection {
       type        = "ssh"
       user        = local.ssh_user
       private_key = file(local.private_key_path)
       host        = self.public_ip
     }
  }

  provisioner "local-exec" {
     command = "ansible-playbook -b -i ${aws_instance.plesk01.public_ip}, --private-key ${local.private_key_path} ../ansible/all.yaml"
   }


}

################ End configuration for Plesk01 #############