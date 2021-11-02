#####################################################
# Kubernetes classic free cluster
# Copyright 2020 IBM
#####################################################
resource "ibm_container_cluster" "cluster" {
  name         = var.cluster_name
  datacenter   = var.worker_zone
  hardware     = var.hardware
  machine_type = "free"

  dynamic taints {
    for_each = (var.taints != null ? var.taints : [])
    content {
      key    = taints.value.key
      value  = taints.value.value
      effect = taints.value.effect
    }
  }

  timeouts {
    create = (var.create_timeout != null ? var.create_timeout : null)
    update = (var.update_timeout != null ? var.update_timeout : null)
    delete = (var.delete_timeout != null ? var.delete_timeout : null)
  }

}