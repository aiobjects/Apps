provider "aws" {
  region = var.REGION
}
#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#}
resource "aws_vpc" "Emc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = " EMC-VPC"
  }
}
resource "aws_subnet" "Emc_Pub1" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "Emc_Pub_Subnet1"
  }
}
resource "aws_subnet" "Emc-Pub2" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "Emc_Pub_Subnet2"
  }
}
resource "aws_subnet" "Emc-Pub3" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "Emc_Pub_Subnet3"
  }
}
resource "aws_subnet" "Emc-Priv1" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "Emc_Priv_Subnet1"
  }
}

resource "aws_subnet" "Emc-Priv2" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "Emc_Priv_Subnet2"
  }
}

resource "aws_subnet" "Emc-Priv3" {
  vpc_id                  = aws_vpc.Emc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "Emc_Priv_Subnet3"
  }
}
resource "aws_internet_gateway" "Emc_IGW" {
  vpc_id = aws_vpc.Emc.id
  tags = {
    Name = "EMC-IGW"
  }
}
resource "aws_route_table" "Emc_Pub_RT" {
  vpc_id = aws_vpc.Emc.id
  tags = {
    Name = "EMC_PUBLIC_ROUTE"
  }
}
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.Emc_Pub_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Emc_IGW.id
}

resource "aws_route_table_association" "EMC_PUB_ASSOC" {
  subnet_id      = aws_subnet.Emc_Pub1.id
  route_table_id = aws_route_table.Emc_Pub_RT.id
}