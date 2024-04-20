resource "aws_route_table" "route_table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.route_table_gateway_id
  }
  vpc_id = var.route_table_vpc_id

  tags = {
    "Name" = var.route_table_tags_Name
  }
}
