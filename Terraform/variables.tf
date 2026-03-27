variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "app_name" {
  description = "Name of the application"
  default     = "color-changer-app"
}

variable "container_port" {
  description = "Port the container listens on"
  default     = 80
}

variable "backend_bucket" {
  description = "S3 bucket for Terraform state"
  default     = "terraform-state-bucket-ecs-project"
}

variable "backend_key" {
  description = "Key for Terraform state"
  default     = "terraform.tfstate"
}