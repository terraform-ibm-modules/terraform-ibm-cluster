#####################################################
# ibm_container_vpc_alb - Enable or disable an Application Load Balancer (ALB) for a VPC cluster.
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "container_vpc_alb" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-alb"

  source = "../../modules/configure-vpc-alb"

  alb_id            = var.alb_id
  enable            = var.enable
  resource_group_id = data.ibm_resource_group.rg.id
}