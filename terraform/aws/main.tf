provider "aws" {
  region = var.region
}
resource "aws_instance" "instance-1" {
  ami           = var.AMIS[var.region]
  instance_type = var.type
  tags          = var.tags
}


