resource "aws_instance" "instance" {
  ami                     = var.instance_ami
  iam_instance_profile = var.instance_iam_instance_profile
  instance_type           = var.instance_instance_type
  key_name = var.instance_key_name
  root_block_device {
    encrypted = true
    tags = var.instance_root_block_device_tags
    volume_size = var.instance_root_block_device_volume_size
    volume_type = "gp3"
  }
  subnet_id = var.instance_subnet_id
  tags = var.instance_tags
  user_data = file(var.instance_user_data)
  vpc_security_group_ids = var.instance_vpc_security_group_ids
}
