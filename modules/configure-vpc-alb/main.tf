#####################################################
# ibm_container_vpc_alb - Enable or disable an Application Load Balancer (ALB) for a VPC cluster.
# Copyright 2020 IBM
#####################################################

resource "ibm_container_vpc_alb" "alb" {
  alb_id            = var.alb_id
  enable            = var.enable != null ? var.enable : true
  resource_group_id = var.resource_group_id != null ? var.resource_group_id : null
}