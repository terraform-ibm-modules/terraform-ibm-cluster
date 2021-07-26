#####################################################
# vpc cluster worker-pool configure
# Copyright 2020 IBM
#####################################################

resource "ibm_container_vpc_worker_pool" "pool" {
  //count              = length(var.worker_pool_data)

  cluster           = var.cluster_name
  vpc_id            = var.virtual_private_cloud
  resource_group_id = var.resource_group_id

  for_each         = var.worker_pool_data
  worker_pool_name = each.key
  flavor           = each.value["flavor"]
  worker_count     = each.value["worker_count"]


  labels      = (var.labels != null ? var.labels : null)
  entitlement = (var.entitlement != null ? var.entitlement : null)

  dynamic zones {
    for_each = (var.worker_zones != null ? var.worker_zones : {})
    content {
      name      = zones.key
      subnet_id = zones.value.subnet_id
    }
  }

  timeouts {
    create = (var.create_timeout != null ? var.create_timeout : null)
    delete = (var.delete_timeout != null ? var.delete_timeout : null)
  }
}