#####################################################
# classic kubernetes single-zone cluster provisioning
# Copyright 2020 IBM
#####################################################

resource "ibm_container_cluster" "cluster" {
  name                     = var.cluster_name
  datacenter               = var.worker_zone
  hardware                 = var.hardware
  resource_group_id        = var.resource_group_id
  default_pool_size        = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  machine_type             = (var.worker_pool_flavor != null ? var.worker_pool_flavor : null)
  public_vlan_id           = (var.public_vlan != null ? var.public_vlan : null)
  private_vlan_id          = (var.private_vlan != null ? var.private_vlan : null)
  public_service_endpoint  = (var.master_service_public_endpoint != null ? var.master_service_public_endpoint : null)
  private_service_endpoint = (var.master_service_private_endpoint != null ? var.master_service_private_endpoint : null)
  disk_encryption          = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  force_delete_storage     = (var.force_delete_storage != null ? var.force_delete_storage : false)
  gateway_enabled          = (var.gateway_enabled != null ? var.gateway_enabled : false)
  kube_version             = (var.kube_version != null ? var.kube_version : null)
  no_subnet                = (var.no_subnet != null ? var.no_subnet : false)
  update_all_workers       = (var.update_all_workers != null ? var.update_all_workers : false)
  tags                     = (var.tags != null ? var.tags : [])
  entitlement              = (var.entitlement != null ? var.entitlement : null)

  dynamic workers_info {
    for_each = (var.workers_info != null ? var.workers_info : [])
    content {
      id      = (workers_info.value.id != "" ? workers_info.value.id : null)
      version = (workers_info.value.version != "" ? workers_info.value.version : null)
    }
  }

  dynamic kms_config {
    for_each = (var.kms_config != null ? var.kms_config : [])
    content {
      instance_id      = kms_config.value.instance_id
      crk_id           = kms_config.value.crk_id
      private_endpoint = (kms_config.value.private_endpoint ? true : false)
    }
  }

  dynamic webhook {
    for_each = (var.webhook != null ? var.webhook : [])
    content {
      level = webhook.value.level
      type  = webhook.value.type
      url   = webhook.value.url
    }
  }

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