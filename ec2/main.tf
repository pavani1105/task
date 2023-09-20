resource "aws_instance" "webapp" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  key_name = "test"
  associate_public_ip_address = "true"

  tags = {
    Name = "webapp"
  }
}
