#####################################################
# ibm_container_alb - Enable or disable an Ingres application load balancer (ALB) that is set up in your cluster.
# Copyright 2020 IBM
#####################################################

resource "ibm_container_alb" "alb" {
  alb_id  = var.alb_id
  enable  = var.enable != null ? var.enable : true
  user_ip = var.user_ip != null ? var.user_ip : null
}