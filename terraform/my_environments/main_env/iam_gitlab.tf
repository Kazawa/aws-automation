module "GitLab_EC2_Role" {
  source = "../../modules/aws_iam_role"

  ir_name = "${var.db_company}-GitlabEC2Role"
  ir_assume_role_policy_Statement_Action = "sts:AssumeRole"
  ir_assume_role_policy_Statement_Effect = "Allow"
  ir_assume_role_policy_Statement_Principal_Service = [
    "ec2.amazonaws.com",
    ]
  ir_tags_Name = "${var.db_company}-GitlabEC2Role"
}

module "GitLab_EC2_Instance_Profile" {
  source = "../../modules/aws_iam_instance_profile"

  iip_name =  module.GitLab_EC2_Role.role_name
  iip_role = module.GitLab_EC2_Role.role_name
  iip_tags_Name = module.GitLab_EC2_Role.role_name
}

module "GitLab_EC2_Policy" {
  source = "../../modules/aws_iam_role_policy"

  irp_name = "${var.db_company}-GitLab_EC2_Policy"
  irp_role = module.GitLab_EC2_Role.role_name
  irp_policy_Statement = [
  {
    "Effect" = "Allow"
    "Action" = [
        "ec2:DescribeInstances",
    ]
    "Resource" = ["*"]
  },
  {
    "Effect" = "Allow"
    "Action" = [
        "ssm:GetParameter",
        "ssm:PutParameter",
    ]
    "Resource" = [
      "arn:aws:ssm:*:590189246993:parameter/${var.db_company}/*",
      "arn:aws:ssm:*:590189246993:parameter/common/*",
    ]
  },
  {
    "Effect" = "Allow"
    "Action" = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
    ]
    "Resource" = [
      "${module.s3_bucket.s3_bucket_arn}/*",
      "${module.s3_bucket.s3_bucket_arn}",
    ]
  },
  ]
}
