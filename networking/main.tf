#----networking/main.tf----

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "lab_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "DEMO-VPC"
  }
}

resource "aws_internet_gateway" "lab_internet_gateway" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  tags = {
    Name = "DEMO-IGW"
  }
}

resource "aws_route_table" "lab_public_rt" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.lab_internet_gateway.id}"
  }

  tags = {
    Name = "DEMO-PUBLIC-ROUTE"
  }
}

resource "aws_route_table" "lab_private_rt" {
  vpc_id = "${aws_vpc.lab_vpc.id}"

  tags = {
    Name = "DEMO-PRIVATE-ROUTE"
  }
}



resource "aws_subnet" "lab_public_subnet" {
 
  vpc_id                  = "${aws_vpc.lab_vpc.id}"
  cidr_block              = "${var.public_cidrs}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "DEMO-PUBLIC"
  }
}

resource "aws_subnet" "lab_private_subnet" {
 
  vpc_id                  = "${aws_vpc.lab_vpc.id}"
  cidr_block              = "${var.private_cidrs}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "DEMO-PRIVATE"
  }
}

resource "aws_route_table_association" "lab_public_assoc" {
  
  subnet_id      = "${aws_subnet.lab_public_subnet.id}"
  route_table_id = "${aws_route_table.lab_public_rt.id}"
}

resource "aws_route_table_association" "lab_private_assoc" {
  
  subnet_id      = "${aws_subnet.lab_private_subnet.id}"
  route_table_id = "${aws_route_table.lab_private_rt.id}"
}

resource "aws_security_group" "web_sg" {
  name        = "WEB-SG"
  description = "Used for access to Web Servers"
  vpc_id      = "${aws_vpc.lab_vpc.id}"

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}
