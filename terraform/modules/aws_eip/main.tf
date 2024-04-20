resource "aws_eip" "eip" {
  instance = var.eip_instance
  public_ipv4_pool = "amazon"
  tags = {
    "Name" = var.eip_tags_Name
  }
  vpc      = true
}
