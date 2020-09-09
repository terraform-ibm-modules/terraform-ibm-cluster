#####################################################
# vpc kubernetes cluster provisioning
# Copyright 2020 IBM
#####################################################

provider "ibm" {
  generation = var.generation
}

data "ibm_resource_group" "test" {
  name = var.resource_group
}

module "vpc_kubernetes_cluster" {
  source = "../../modules/vpc-kubernetes-cluster"

  cluster_name                    = var.cluster_name
  vpc_id                          = var.vpc_id
  worker_pool_flavor              = var.worker_pool_flavor
  worker_zones                    = var.worker_zones
  worker_nodes_per_zone           = (var.worker_nodes_per_zone != null ? var.worker_nodes_per_zone : 1)
  resource_group_id               = data.ibm_resource_group.test.id 
  kube_version                    = (var.kube_version != null ? var.kube_version : null)
  update_all_workers              = (var.update_all_workers != null ? var.update_all_workers : false)
  service_subnet                  = (var.service_subnet != null ?  var.service_subnet : "172.21.0.0/16")
  pod_subnet                      = (var.pod_subnet != null ? var.pod_subnet : "172.30.0.0/16")
  worker_labels                   = (var.worker_labels != null ? var.worker_labels : null)
  wait_till                       = (var.wait_till != null ? var.wait_till  : "ingressReady")
  disable_public_service_endpoint = (var.disable_public_service_endpoint != null ? var.disable_public_service_endpoint : true)
  tags                            = (var.tags != null ? var.tags : [])
  cos_instance_crn                = (var.cos_instance_crn != null ? var.cos_instance_crn : null)
  force_delete_storage            = (var.force_delete_storage != null ? var.force_delete_storage : false)
  kms_config                      = (var.kms_config != null ? var.kms_config :[])

}