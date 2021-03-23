########################################################
# vpc cluster worker pool configuration
# Copyright 2020 IBM
########################################################

provider "ibm" {
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "vpc_cluster_worker_pool" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"
  
  cluster_name                    = var.cluster_name
  worker_pool_name                = var.worker_pool_name
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  flavor                          = var.flavor
  resource_group_id               = data.ibm_resource_group.test.id
  virtual_private_cloud           = var.virtual_private_cloud
  worker_zones                    = var.worker_zones
  labels                          = var.labels 
  entitlement                     = var.entitlement
}