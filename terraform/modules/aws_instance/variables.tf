variable "instance_ami" {
  description = "EC2 AMI ID"
  type = string
  default = ""
}
variable "instance_iam_instance_profile" {
  description = "IAM Instance Profile Name"
  type = string
  default = ""
}
variable "instance_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.small"
}
variable "instance_key_name" {
  description = "SSH Key Name and Location"
  type = string
  default = ""
}
variable "instance_tags" {
  description = "EC2 Instance Name"
  type = map
  default = {}
}
variable "instance_root_block_device_volume_size" {
  description = "Size in GB of root volume"
  type = number
  default = 10
}
variable "instance_root_block_device_tags" {
  description = "Tag's for the Instance Root Block Device"
  type = map
  default = {}
}
variable "instance_subnet_id" {
  description = "EC2 Subnet to launch in"
  type = string
  default = ""
}
variable "instance_user_data" {
  description = "Location of user_data file"
  type = string
  default = ""
}
variable "instance_vpc_security_group_ids" {
  description = "List of VPC Security Group ID's"
  type = list
  default = []
}
