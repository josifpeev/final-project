resource "aws_eip" "plesk01" {
  vpc = true
    association {
    instance_id = aws_instance.plesk01.id

  }
}