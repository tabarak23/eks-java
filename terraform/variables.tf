variable "region" {
  description = "AWS region"
  type        = string
}

variable "clusterName" {
  description = "Base name of EKS cluster"
  type        = string
}

variable "environment" {
  description = "Environment name (staging or prod)"
  type        = string
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
}

variable "node_count" {
  description = "Number of EKS worker nodes"
  type        = number
}
