provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "instance-1" {

  ami           = "ami-006d3995d3a6b963b"
  instance_type = "t2.micro"
  tags = {
    Name = "RAJA-TEST"
  }
}

