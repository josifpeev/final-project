packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "plesk-build-{timestamp}"
  instance_type = "t2.micro"
  region        = "eu-west-1"
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
        "sudo curl -s https://autoinstall.plesk.com/plesk-installer | sudo bash",
        "sudo apt-get install -y plesk-core plesk-php72-fpm plesk-php73-fpm plesk-php74-fpm",
        "sudo plesk install admin --email {{user `plesk_email`}} --passwd {{user `plesk_password`}}",
        "sudo apt-get upgrade -y"
    ]
  }
}