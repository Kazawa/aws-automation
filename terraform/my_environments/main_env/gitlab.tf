module "gitlab" {
  source = "../../modules/aws_instance"

  instance_ami = data.aws_ami.gitlab_ami.id
  instance_iam_instance_profile = module.GitLab_EC2_Instance_Profile.profile_name
  instance_instance_type = var.db_ec2_instance_instance_type
  instance_key_name = "bundt"
  instance_tags = {
    Name = "${var.db_company}-gitlab",
    Company = "${var.db_company}",
  }
  instance_root_block_device_volume_size = 12
  instance_root_block_device_tags = {
    Name = "${var.db_company}-root"
  }
  instance_subnet_id = data.aws_subnets.subnets_Common_A.ids[0]
  instance_user_data = "user_data.yml"
  instance_vpc_security_group_ids = [module.gitlab_security_group.security_group_id]
}

module "gitlab_eip" {
  source = "../../modules/aws_eip"

  eip_instance = module.gitlab.instance_id
  eip_tags_Name = "${var.db_company}-gitlab-eip"
}

module "gitlab_r53_record" {
  source = "../../modules/aws_route53_record"

  route53_record_name = "${var.db_company}"
  route53_record_records = [module.gitlab_eip.public_ip]
  route53_record_type = "A"
  route53_record_zone_id = data.aws_route53_zone.route53_zone_gltest.zone_id
}

module "gitlab_security_group" {
  source = "../../modules/aws_security_group"

  security_group_tags_Name = "${var.db_company}-sg"
  security_group_vpc_id = module.main_vpc.vpc_id
}

module "gitlab_sg_rule_http" {
  source = "../../modules/aws_security_group_rule/http"

  security_group_rule_cidr_blocks = ["0.0.0.0/0"]
  security_group_rule_security_group_id = module.gitlab_security_group.security_group_id
}

module "gitlab_sg_rule_https" {
  source = "../../modules/aws_security_group_rule/https"

  security_group_rule_cidr_blocks = ["${data.external.my_public_ip.result.my_pub_ip}/32"]
  security_group_rule_security_group_id = module.gitlab_security_group.security_group_id
}

module "gitlab_sg_rule_ssh" {
  source = "../../modules/aws_security_group_rule/ssh"

  security_group_rule_cidr_blocks = ["${data.external.my_public_ip.result.my_pub_ip}/32"]
  security_group_rule_security_group_id = module.gitlab_security_group.security_group_id
}
