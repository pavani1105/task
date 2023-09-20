module "vpc" {
  source = "./vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
   source = "./ec2"
   ami_id = "ami-06ca3ca175f37dd66"
   instance_type = "t2.micro"
   public_subnet_id = module.vpc.public_subnet_id
}
