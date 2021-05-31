########################################################
# kubernetes classic cluster worker pool configuration
# Copyright 2020 IBM
########################################################

provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "classic_cluster_worker_pool" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-classic-worker-pool"

  cluster_name       = var.cluster_name
  worker_pool_name   = var.worker_pool_name
  worker_nodes       = var.worker_nodes
  flavor             = var.flavor
  worker_zones       = var.worker_zones
  resource_group_id  = data.ibm_resource_group.rg.id
  wait_till_albs     = var.wait_till_albs
  hardware           = var.hardware
  encrypt_local_disk = var.encrypt_local_disk
  labels             = var.labels
}