resource "aws_security_group" "Emc_Stack_Sg" {
  vpc_id      = aws_vpc.Emc.id
  name        = "VPC_STACK_SG"
  description = "Security group for ssh"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
  }
}
