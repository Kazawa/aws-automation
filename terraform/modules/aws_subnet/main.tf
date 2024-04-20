resource "aws_subnet" "subnet" {
  availability_zone =  var.subnet_availability_zone
  cidr_block = var.subnet_cidr_block
  vpc_id     = var.subnet_vpc_id

  tags = {
    Name = var.subnet_tags_Name
  }
}
