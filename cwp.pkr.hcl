#{
#  "variables": {
#    "aws_access_key": "",
#    "aws_secret_key": ""
#  },

  "builders": [
    {
      "type": "amazon-ebs",
 #     "access_key": "{{user `aws_access_key`}}",
 #     "secret_key": "{{user `aws_secret_key`}}",
      "region": "eu-west-1",
      "instance_type": "t2.micro",
      "source_ami_filter": {
        "filters": {
          "virtualization-type": "hvm",
          "name": "ubuntu/images/*ubuntu-focal-20.04-amd64-server*",
          "root-device-type": "ebs"
        },
        "owners": ["099720109477"],
        "most_recent": true
      },
      "ssh_username": "ubuntu",
      "ami_name": "packer-example-{{timestamp}}"
    }
  ],

  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo apt-get update",
        "sudo apt-get install -y curl",
        "sudo curl -s https://autoinstall.plesk.com/plesk-installer | sudo bash",
        "sudo apt-get install -y plesk-core plesk-php72-fpm plesk-php73-fpm plesk-php74-fpm",
        "sudo plesk install admin --email {{user `plesk_email`}} --passwd {{user `plesk_password`}}",
        "sudo apt-get upgrade -y"
      ]
    }
  ]
}
