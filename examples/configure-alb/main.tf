#####################################################
# ibm_container_alb - Enable or disable an Ingres application load balancer (ALB) that is set up in your cluster.
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "container_alb" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-alb"

  source = "../../modules/configure-alb"

  alb_id  = var.alb_id
  enable  = var.enable
  user_ip = var.user_ip
}