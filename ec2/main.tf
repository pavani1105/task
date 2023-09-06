resource "aws_instance" "ec2_instance" {
  ami = "ami-08a52ddb321b32a8c"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  #subnet_id = aws_subnet.publicsubnet.id
  key_name = "test"
  associate_public_ip_address = "true"

  tags = {
    Name = "ec2_instance"
  }
}
