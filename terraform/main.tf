provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "plesk01" {
  ami           = "ami-0d385ef28de9ef4ea"
  instance_type = "t2.micro"
}
