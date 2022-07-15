resource "aws_key_pair" "Emc_key" {
  key_name   = "Emc"
  public_key = file(var.PUB-KEY)
}
resource "aws_instance" "Emc_Web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Emc_Pub1.id
  key_name               = aws_key_pair.Emc_key.key_name
  vpc_security_group_ids = [aws_security_group.Emc_Stack_Sg.id]
  tags = {
    Name = "WEB_INSTANCE"
  }
}
output "publicIp" {
  value = aws_instance.Emc_Web.public_ip
}
