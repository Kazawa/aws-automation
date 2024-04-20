output "vpc_id" {
  value = module.main_vpc.vpc_id
}
output "commonA" {
  value = data.aws_subnets.subnets_Common_A.ids[0]
}
