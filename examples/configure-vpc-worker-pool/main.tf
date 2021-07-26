########################################################
# vpc cluster worker pool configuration
# Copyright 2020 IBM
########################################################

provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "vpc_cluster_worker_pool" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"
  source = "../../modules/configure-vpc-worker-pool"

  cluster_name          = var.cluster_name
  worker_pool_data      = var.worker_pool_data
  resource_group_id     = data.ibm_resource_group.rg.id
  virtual_private_cloud = var.virtual_private_cloud
  worker_zones          = var.worker_zones
  labels                = var.labels
  entitlement           = var.entitlement
  create_timeout        = var.create_timeout
  delete_timeout        = var.delete_timeout
}