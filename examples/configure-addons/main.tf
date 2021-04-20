#####################################################
# Configure Add-ons to a cluster
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "classic_kubernetes_worker_pool" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-addons"

  cluster_name = var.cluster_name
  add_ons      = var.add_ons
}