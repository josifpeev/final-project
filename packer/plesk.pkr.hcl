packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "plesk-build-t2.mirco"
  instance_type = "t2.micro"
  region        = "eu-west-1"

# Add 20GB volume
  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 20
    volume_type = "gp2"
    delete_on_termination = true
    }

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      
    }
    
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "root"
}

build {
  name    = "plesk-build"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]


provisioner "shell" {
      inline = [
#        "sudo apt-get update",
#        "sudo apt upgrade -y",
#        "sudo wget https://autoinstall.plesk.com/one-click-installer",
#        "sudo chmod +x one-click-installer",
#        "sudo ./one-click-installer",
#        "sudo apt clean",
#        "sudo apt autoremove -y",
        "sudo mkdir -p /root/.ssh/",
        "sudo touch /root/.ssh/authorized_keys",
        "sudo echo \"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCGDf/JQFwPxLHI33dPxyAIImARZFdiOGmPcK3TkjqTxV0l97qjea+RxNl2ciF/qme8oSU3docyoyazd1/ivy81+1PzaR7vhxlG6eumjfN0RynC84+kTxc69vu25p0G5VU3xd8c4LI6NJ/OOKWDxUN7xeHTT1TgRc2Xh4OfEPgdsqC0bsSzrScQv2eRh3fSQjF+wYOv0gL6i8TuFRnCwhzkJddnlNA4/Po7LnZDfRvsRAhOgcc9zrbAVHcwDs+osngfWZ58UOYtDmSxV2UwN8BauNLyuxzwRDU7uTv+IaQDrshxsfZvHKHoD+KBWkpf3BR8FInJ0aiK75SznOi2u44/d+oNExZ0AeYYCIP7UipwIW/+IwWJVAb//HOfogqHKWmCo2+BhllRSao6o8UZ5xbwLaxCnRi3pv1yZOkOm1dEQPWkqQsadfXfQiDoyV0wE6JvI7Of9exua8PQT54BL95Kqaw9sZ7jymSPqSaA5b314fY9+B4xDL7POHHBtaNxp5U= root@aws\" > /root/.ssh/authorized_keys",
        "sudo chmod 600 /root/.ssh/authorized_keys"


    ]
  }
} 

