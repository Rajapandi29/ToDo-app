project_name         = "todo-app"
environment          = "dev"
aws_region           = "us-east-1"

vpc_cidr             = "10.0.0.0/16"

public_subnet_cidrs  = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

container_port = 3001

cpu           = 512
memory        = 1024
desired_count = 1

alerts_email = "rajapandi6321613@gmail.com"
alert_phone  = "+917604961578"



alb_name = "todo-app-dev-alb"



sample_project_name   = "sample-app"
sample_container_port = 3001

sample_cpu           = 512
sample_memory        = 1024
sample_desired_count = 1

sample_health_check_path = "/"

sample_listener_priority = 100