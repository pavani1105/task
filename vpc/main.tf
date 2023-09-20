resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = var.dnssupport
    enable_dns_hostnames = var.dnshostnames
    tags = {
       Name = "main"
     }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = "true"
    tags = {
      Name = "public"
    }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "Publicrt"
    }
}

resource "aws_route_table_association" "pub_association" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.publicrt.id  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    tags = {
        Name = "private"
    }
} 

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "privatert"
   }
}

resource "aws_route_table_association" "pri_association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.privatert.id
}

resource "aws_security_group" "mynewsg" {
  name = "mynewsg"
  description = "allow ssh http https traffic"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "ssh traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
   description = "http traffic"
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress { 
   description = "https traffic"
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
}
resource "aws_key_pair" "test" {
  key_name = "test"
  public_key = "Place here Publickey"
}
