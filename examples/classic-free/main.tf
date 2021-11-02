#####################################################
# kubernetes classic free cluster provisioning
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "classic_free_cluster" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/classic-free"

  source = "../../modules/classic-free"

  cluster_name   = var.cluster_name
  worker_zone    = var.worker_zone
  hardware       = var.hardware
  taints         = var.taints
  create_timeout = var.create_timeout
  update_timeout = var.update_timeout
  delete_timeout = var.delete_timeout
}