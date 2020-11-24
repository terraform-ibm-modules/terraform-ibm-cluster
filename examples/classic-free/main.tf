#####################################################
# kubernetes classic free cluster provisioning
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "classic_free_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/classic-free"
  
  cluster_name        = var.cluster_name
  worker_zone         = var.worker_zone
  hardware            = var.hardware
}