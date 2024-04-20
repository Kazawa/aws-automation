data "aws_subnets" "subnets_Common_A" {
  filter {
    name = "tag:Name"
    values = ["*Common_A*"]
  }
  # Cannot get VPC and Subnet data before VPC and Subnets are Created
  depends_on = [module.main_vpc_subnet_Common_A]
}
data "aws_subnets" "subnets_Common_B" {
  filter {
    name = "tag:Name"
    values = ["*Common_B*"]
  }
}
data "aws_subnets" "subnets_Application_A" {
  filter {
    name = "tag:Name"
    values = ["*Application_A*"]
  }
}
data "aws_subnets" "subnets_Application_B" {
  filter {
    name = "tag:Name"
    values = ["*Application_B*"]
  }
}
data "aws_route53_zone" "route53_zone_gltest" {
  name         = "gltest.link"
  private_zone = false
}
data "external" "my_public_ip" {
  program = ["bash", "-c", "jq -n --arg get_ip $(dig +short myip.opendns.com @resolver1.opendns.com) '{\"my_pub_ip\":$get_ip}'"]
}
data "aws_ami" "gitlab_ami" {
  most_recent      = true
  owners           = ["self"]
  filter {
    name   = "name"
    values = ["gitlab-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}
data "aws_iam_policy_document" "ses_send_raw_email" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}
