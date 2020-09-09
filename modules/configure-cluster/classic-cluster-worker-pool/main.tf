#####################################################
# classic kubernetes worker-pool configure
# Copyright 2020 IBM
#####################################################

resource "ibm_container_worker_pool" "test_pool" {
  cluster           = var.cluster_name
  machine_type      = var.flavor
  worker_pool_name  = var.worker_pool_name
  size_per_zone     = var.worker_nodes
  hardware          = var.hardware 
  disk_encryption   = var.encrypt_local_disk
  labels            = var.labels
  resource_group_id = var.resource_group_id
}

resource "ibm_container_worker_pool_zone_attachment" "zones" {
  cluster           = var.cluster_name
  worker_pool       = element(split("/", ibm_container_worker_pool.test_pool.id), 1)
  for_each          = var.worker_zones
  zone              = each.key
  public_vlan_id    = each.value["public_vlan"]
  private_vlan_id   = each.value["private_vlan"]
  wait_till_albs    = var.wait_till_albs
  resource_group_id = var.resource_group_id
}

