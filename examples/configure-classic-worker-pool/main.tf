########################################################
# kubernetes classic cluster worker pool configuration
# Copyright 2020 IBM
########################################################

provider "ibm" {
}

data "ibm_resource_group" "test" {
  name =  var.resource_group 
}

module "classic_cluster_worker_pool" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/configure-classic-worker-pool"
  
  cluster_name                    = var.cluster_name
  worker_pool_name                = var.worker_pool_name
  worker_nodes                    = var.worker_nodes
  flavor                          = var.flavor
  worker_zones                    = var.worker_zones
  resource_group_id               = data.ibm_resource_group.test.id
  wait_till_albs                  = (var.wait_till_albs != null ? var.wait_till_albs : true)
  hardware                        = (var.hardware != null ? var.hardware : "shared")
  encrypt_local_disk              = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  labels                          = (var.labels != null ? var.labels : null )
}