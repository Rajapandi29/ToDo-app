
output "vpc_id" {
  value = module.vpc.vpc_id
}


output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}


output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}


output "alb_dns_name" {
  value = module.alb.alb_dns_name
}


output "alb_arn" {
  value = module.alb.alb_arn
}


output "todo_ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}


output "todo_target_group_arn" {
  value = module.alb.target_group_arn
}


output "sample_ecr_repository_url" {
  value = module.sample_ecr.ecr_repository_url
}


output "sample_target_group_arn" {
  value = aws_lb_target_group.sample.arn
}


output "sample_url" {
  value = "http://${var.alb_name}/sample"
}