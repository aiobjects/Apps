/*
1.Declare the cloud provider
2.create resource vpc
3.create public subnet
4.create private subnet.
5.create InternetGateWay
6.Create Elastic_Ip for Nat InternetGateWay
7.Create Nat gateway
8.create route_table for public subnet
9.create route_table for private subnet
10.create security group
11.create route_table_association with public route_table
12. create route_table_assciation with private route_table 
*/

provider "aws"{
    region = "ap-south-1"
}

resource "aws_vpc" "vpc"{
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags ={
        Name = "demo-vpc"
    }
}

resource "aws_subnet" "pub"{
    vpc_id=aws_vpc.vpc.id 
    cidr_block = "192.168.1.0/24"
    tags = {
        Name= "public"
    }
}

resource "aws_subnet" "pri"{
    vpc_id=aws_vpc.vpc.id 
    cidr_block = "192.168.3.0"
    tags = {
        Name = "private"
    }

}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.vpc.id 
    subnet_id = aws_subnet.pub.id 
    tags = {
        Name = "IGW"
    }
}

resource "aws_eip" "ip"{
    vpc=true
}

resource "aws_nat_gateway" "ngw"{
    allocation_id = aws_eip.ip.id
    subnet_id = aws_subnet.pri.id
    tags ={
        Name = "NGW"
    }
}

resource "aws_route_table" "rt1"{
    vpc_id = aws_vpc.vpc.id 
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

resoure "aws_route_table" "rt2"{
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
    }
}

resource "security_group" "sg"{
    vpc_id = aws_vpc.vpc.id
    ingress{
        from_port =22
        to_port = 22
        protocol = tcp
        cidr_blocks = "aws_vpc.vpc.cidr_block"

    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "[0.0.0.0/0]"
    }
}

resource "aws_resource_table_association" "as-1"{
  subnet_id = aws_subnet.pub.id 
  route_table_id = aws_route_table.rt1.id
}

resource "aws_resource_table_association" "as-2"{
   subnet_id = "aws_subnet.pri.id"
   route_table_id = aws_route_table.rt2.id
}