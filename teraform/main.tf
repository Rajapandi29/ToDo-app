module "vpc" {
  source = "s3::https://s3-us-east-1.amazonaws.com/terraform-module-23-8/vpc"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}
resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-${var.environment}-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

resource "aws_sns_topic_subscription" "sms_alert" {
  count     = var.alert_phone != "" ? 1 : 0
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "sms"
  endpoint  = var.alert_phone
}

resource "aws_sns_topic_policy" "allow_cloudwatch_publish" {
  arn = aws_sns_topic.alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowPublish"
        Effect = "Allow"

        Principal = {
          Service = [
            "events.amazonaws.com",
            "cloudwatch.amazonaws.com"
          ]
        }

        Action   = "SNS:Publish"
        Resource = aws_sns_topic.alerts.arn
      }
    ]
  })
}

module "alb" {
  source = "s3::https://s3-us-east-1.amazonaws.com/terraform-module-23-8/alb"

  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  container_port      = var.container_port
  alert_sns_topic_arn = aws_sns_topic.alerts.arn
}


module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

module "ecs" {
  source = "./modules/ecs"

  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_sg_id          = module.alb.alb_sg_id

  container_image    = "${module.ecr.ecr_repository_url}:latest"
  container_port     = var.container_port

  cpu                = var.cpu
  memory             = var.memory
  desired_count      = var.desired_count

  target_group_arn   = module.alb.target_group_arn

  alert_sns_topic_arn = aws_sns_topic.alerts.arn
}

module "sample_ecr" {
  source = "./modules/ecr"

  project_name = var.sample_project_name
  environment  = var.environment
}
data "aws_lb" "existing" {
  name = var.alb_name

  depends_on = [
    module.alb
  ]
}

data "aws_lb_listener" "http" {
  load_balancer_arn = data.aws_lb.existing.arn
  port              = 80

  depends_on = [
    module.alb
  ]
}

resource "aws_lb_target_group" "sample" {
  name        = "${var.sample_project_name}-${var.environment}-tg"
  port        = var.sample_container_port
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    path                = var.sample_health_check_path
    protocol            = "HTTP"
    port                = "traffic-port"

    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval             = 30
  }

  tags = {
    Name        = "${var.sample_project_name}-${var.environment}-tg"
    Application = var.sample_project_name
    Environment = var.environment
  }
}

resource "aws_lb_listener_rule" "sample" {
  listener_arn = data.aws_lb_listener.http.arn
  priority     = var.sample_listener_priority

  condition {
    path_pattern {
      values = [
        "/sample",
        "/sample/*"
      ]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sample.arn
  }
}
module "sample_ecs" {
  source = "./modules/ecs"

  project_name       = var.sample_project_name
  environment        = var.environment
  aws_region         = var.aws_region

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  alb_sg_id          = module.alb.alb_sg_id

  container_image    = "${module.sample_ecr.ecr_repository_url}:latest"
  container_port     = var.sample_container_port

  cpu                = var.sample_cpu
  memory             = var.sample_memory
  desired_count      = var.sample_desired_count

  target_group_arn   = aws_lb_target_group.sample.arn

  alert_sns_topic_arn = aws_sns_topic.alerts.arn
}
