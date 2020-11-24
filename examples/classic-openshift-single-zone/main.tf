#####################################################
# classic kubernetes single-zone cluster provisioning
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "classic_openshift_single_zone_cluster" {
  source  = "terraform-ibm-modules/cluster/ibm//modules/classic-openshift-single-zone"

  cluster_name                    = var.cluster_name
  worker_zone                     = var.worker_zone
  hardware                        = var.hardware 
  resource_group_id               = data.ibm_resource_group.test.id
  worker_nodes_per_zone           = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  worker_pool_flavor              = (var.worker_pool_flavor != null ? var.worker_pool_flavor : null)
  public_vlan                     = (var.public_vlan_id != null ? var.public_vlan_id : null)
  private_vlan                    = (var.private_vlan_id != null ? var.private_vlan_id : null)
  master_service_public_endpoint  = (var.master_service_public_endpoint != null ? var.master_service_public_endpoint : null)
  master_service_private_endpoint = (var.master_service_private_endpoint != null ? var.master_service_private_endpoint : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  gateway_enabled                 = (var.gateway_enabled != null ? var.gateway_enabled : false)
  encrypt_local_disk              = (var.encrypt_local_disk != null ? var.encrypt_local_disk : true)
  no_subnet                       = (var.no_subnet != null ? var.no_subnet : false)
  subnet_id                       = (var.subnet_id != null ? var.subnet_id : []) 
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  tags                            = (var.tags != null ? var.tags : [])
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  kms_config                      = (var.kms_config != null ? var.kms_config :[])
  workers_info                    = (var.workers_info != null ? var.workers_info : [])
  webhook                         = (var.webhook != null ? var.webhook : [])
  entitlement                     = (var.entitlement != null ? var.entitlement : null)

}