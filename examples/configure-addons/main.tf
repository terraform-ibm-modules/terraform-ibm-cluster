#####################################################
# Configure Add-ons to a cluster
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "classic_kubernetes_worker_pool" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-addons"

  source         = "../../modules/configure-addons"
  cluster_name   = var.cluster_name
  add_ons        = var.add_ons
  create_timeout = var.create_timeout
  update_timeout = var.update_timeout
}