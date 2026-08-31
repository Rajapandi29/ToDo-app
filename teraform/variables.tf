variable "project_name" {
  type        = string
  description = "Todo application project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}



variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
}



variable "container_port" {
  type        = number
  description = "Todo application container port"
}

variable "cpu" {
  type        = number
  description = "Todo ECS CPU"
}

variable "memory" {
  type        = number
  description = "Todo ECS memory"
}

variable "desired_count" {
  type        = number
  description = "Todo ECS desired task count"
}


variable "alerts_email" {
  type        = string
  description = "SNS alert email address"
}

variable "alert_phone" {
  type        = string
  description = "SNS alert phone number"

  default = ""
}


variable "alb_name" {
  type        = string
  description = "Existing ALB name created by the S3 ALB module"
}


variable "sample_project_name" {
  type        = string
  description = "Sample application project name"
}

variable "sample_container_port" {
  type        = number
  description = "Sample application container port"
}

variable "sample_cpu" {
  type        = number
  description = "Sample ECS CPU"
}

variable "sample_memory" {
  type        = number
  description = "Sample ECS memory"
}

variable "sample_desired_count" {
  type        = number
  description = "Sample ECS desired task count"
}



variable "sample_health_check_path" {
  type        = string
  description = "Sample application health check path"
}

variable "sample_listener_priority" {
  type        = number
  description = "ALB listener rule priority for Sample application"
}