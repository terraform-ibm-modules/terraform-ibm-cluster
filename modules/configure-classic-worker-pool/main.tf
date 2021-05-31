#####################################################
# classic kubernetes worker-pool configure
# Copyright 2020 IBM
#####################################################

resource "ibm_container_worker_pool" "pool" {
  cluster           = var.cluster_name
  machine_type      = var.flavor
  worker_pool_name  = var.worker_pool_name
  size_per_zone     = var.worker_nodes
  resource_group_id = var.resource_group_id
  hardware          = (var.hardware != null ? var.hardware : "shared")
  disk_encryption   = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  labels            = (var.labels != null ? var.labels : null)
}

resource "ibm_container_worker_pool_zone_attachment" "zones" {
  cluster           = var.cluster_name
  worker_pool       = element(split("/", ibm_container_worker_pool.pool.id), 1)
  wait_till_albs    = (var.wait_till_albs != null ? var.wait_till_albs : true)
  resource_group_id = var.resource_group_id

  for_each        = var.worker_zones
  zone            = each.key
  public_vlan_id  = each.value["public_vlan"]
  private_vlan_id = each.value["private_vlan"]

}

