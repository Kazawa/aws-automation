packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "rhel_8" {
  ami_name      = "gitlab-gold"
  instance_type = "t2.micro"
  region        = "us-east-2"
  subnet_id = "subnet-05d48f778a7174b4f" # make this a data point
  associate_public_ip_address = true
  vpc_id = "vpc-0ee7e5fd0b3dc0c45" # could make this an environment variable
  source_ami_filter {
    filters = {
      name                = "*RHEL-8*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture = "x86_64"
    }
    most_recent = true
    owners      = ["309956199498"]
  }
  ssh_username = "ec2-user"

}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.rhel_8"
  ]
}
