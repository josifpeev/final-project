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
  ssh_username = "ubuntu"
}

build {
  name    = "plesk-build"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]



provisioner "shell" {
      inline = [
        "sudo apt-get update",
        "sudo apt-get install -y curl",
        "sudo wget https://autoinstall.plesk.com/one-click-installer",
        "sudo chmod +x one-click-installer",
        "sudo apt autoremove; sudo apt clean",
        "sudo ./one-click-installer"
    ]
  }
}

