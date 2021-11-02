#####################################################
# ibm_container_vpc_alb - Enable or disable an Application Load Balancer (ALB) for a VPC cluster.
# Copyright 2020 IBM
#####################################################

output "alb_id" {
  description = "The unique identifier of the ALB."
  value       = ibm_container_vpc_alb.alb.id
}

output "name" {
  description = "The name of the ALB"
  value       = ibm_container_vpc_alb.alb.name
}

output "alb_type" {
  description = "The type of the ALB. Supported values are public and private"
  value       = ibm_container_vpc_alb.alb.alb_type
}

output "cluster" {
  description = "The name of the cluster where the ALB is provisioned."
  value       = ibm_container_vpc_alb.alb.cluster
}
