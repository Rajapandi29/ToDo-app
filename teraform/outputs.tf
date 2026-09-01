output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_listener_arn" {
  value = module.alb.alb_listener_arn
}

output "alb_sg_id" {
  value = module.alb.alb_sg_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "todo_target_group_arn" {
  value = module.alb.target_group_arn
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}