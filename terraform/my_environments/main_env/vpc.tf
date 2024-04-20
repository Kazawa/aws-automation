module "main_vpc" {
  source = "../../modules/aws_vpc"

  vpc_cidr_block = "10.0.0.0/22"
  vpc_tags_Name = "${var.db_company}_vpc"
}

module "main_vpc_subnet_Application_A" {
  source = "../../modules/aws_subnet"
  
  subnet_availability_zone = "us-east-2a"
  subnet_cidr_block = "10.0.0.0/24"
  subnet_vpc_id = module.main_vpc.vpc_id
  subnet_tags_Name = "${var.db_company}_Application_A"
}

module "main_vpc_subnet_Application_B" {
  source = "../../modules/aws_subnet"

  subnet_availability_zone = "us-east-2b"
  subnet_cidr_block = "10.0.1.0/24"
  subnet_vpc_id = module.main_vpc.vpc_id
  subnet_tags_Name = "${var.db_company}_Application_B"
}

module "main_vpc_subnet_Common_A" {
  source = "../../modules/aws_subnet"

  subnet_availability_zone = "us-east-2a"
  subnet_cidr_block = "10.0.2.0/24"
  subnet_vpc_id = module.main_vpc.vpc_id
  subnet_tags_Name = "${var.db_company}_Common_A"
}

module "main_vpc_subnet_Common_B" {
  source = "../../modules/aws_subnet"

  subnet_availability_zone = "us-east-2b"
  subnet_cidr_block = "10.0.3.0/24"
  subnet_vpc_id = module.main_vpc.vpc_id
  subnet_tags_Name = "${var.db_company}_Common_B"
}

module "main_vpc_internet_gateway" {
  source = "../../modules/aws_internet_gateway"

  internet_gateway_vpc_id = module.main_vpc.vpc_id
  internet_gateway_tags_Name = "${var.db_company}_ig"
}

module "main_vpc_route_table" {
  source = "../../modules/aws_route_table"

  route_table_gateway_id = module.main_vpc_internet_gateway.gw_id
  route_table_vpc_id = module.main_vpc.vpc_id
  route_table_tags_Name = "${var.db_company}_rt"

  depends_on = [
    module.main_vpc
  ]
}

module "main_vpc_route_table_association" {
  source = "../../modules/aws_main_route_table_association"

  mrta_route_table_id = module.main_vpc_route_table.route_table_id
  mrta_vpc_id = module.main_vpc.vpc_id
}
