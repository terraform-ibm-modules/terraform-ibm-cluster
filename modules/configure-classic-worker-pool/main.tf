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

  dynamic taints {
    for_each = (var.taints != null ? var.taints : [])
    content {
      key    = taints.value.key
      value  = taints.value.value
      effect = taints.value.effect
    }
  }

  timeouts {
    update = (var.update_timeout != null ? var.update_timeout : null)
  }
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

  timeouts {
    create = (var.create_timeout != null ? var.create_timeout : null)
    update = (var.update_timeout != null ? var.update_timeout : null)
    delete = (var.delete_timeout != null ? var.delete_timeout : null)
  }

}

