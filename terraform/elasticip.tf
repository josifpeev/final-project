resource "aws_eip" "plesk01" {
  vpc = true
  associate_with_private_ip = aws_instance.plesk01.private_ip
}