#####################################################
# vpc openshift cluster provisioning
# Copyright 2020 IBM
#####################################################

resource "ibm_container_vpc_cluster" "cluster" {

  name                            = var.cluster_name
  vpc_id                          = var.vpc_id
  flavor                          = var.worker_pool_flavor
  resource_group_id               = var.resource_group_id
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  service_subnet                  = (var.service_subnet != null ? var.service_subnet : null)
  worker_count                    = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  worker_labels                   = (var.worker_labels != null ? var.worker_labels : null)
  disable_public_service_endpoint = (var.disable_public_service_endpoint != null ? var.disable_public_service_endpoint : false)
  tags                            = (var.tags != null ? var.tags : null)
  wait_till                       = (var.wait_till != null ? var.wait_till : "ingressReady")
  cos_instance_crn                = (var.cos_instance_crn != null ? var.cos_instance_crn : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  entitlement                     = (var.entitlement != null ? var.entitlement : null)

  dynamic zones {
    for_each = (var.worker_zones != null ? var.worker_zones : {})
    content {
      name      = zones.key
      subnet_id = zones.value.subnet_id
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