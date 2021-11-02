#####################################################
# ibm_container_alb - Enable or disable an Ingres application load balancer (ALB) that is set up in your cluster.
# Copyright 2020 IBM
#####################################################

output "alb_id" {
  description = "The unique identifier of the ALB."
  value       = ibm_container_alb.alb.id
}

output "name" {
  description = "The name of the ALB"
  value       = ibm_container_alb.alb.name
}

output "alb_type" {
  description = "The type of the ALB. Supported values are public and private"
  value       = ibm_container_alb.alb.alb_type
}

output "cluster" {
  description = "The name of the cluster where the ALB is provisioned."
  value       = ibm_container_alb.alb.cluster
}
