#####################################################
# Cluster Resources Configuration
# Copyright 2021 IBM
#####################################################

provider "ibm" {
}

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

module "classic_kubernetes_multi_zone_cluster" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/classic-kubernetes-multi-zone"
  source                          = "../../modules/classic-kubernetes-multi-zone"
  cluster_name                    = var.cluster_name
  metro                           = var.metro
  hardware                        = var.hardware
  resource_group_id               = data.ibm_resource_group.rg.id
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  worker_pool_flavor              = var.worker_pool_flavor
  public_vlan                     = var.public_vlan_id
  private_vlan                    = var.private_vlan_id
  master_service_public_endpoint  = var.master_service_public_endpoint
  master_service_private_endpoint = var.master_service_private_endpoint
  force_delete_storage            = var.force_delete_storage
  gateway_enabled                 = var.gateway_enabled
  encrypt_local_disk              = var.encrypt_local_disk
  no_subnet                       = var.no_subnet
  subnet_id                       = var.subnet_id
  update_all_workers              = var.update_all_workers
  tags                            = var.tags
  kube_version                    = var.kube_version
  taints                          = var.taints
  wait_till_albs                  = var.wait_till_albs
  create_timeout                  = var.create_timeout
  update_timeout                  = var.update_timeout
  delete_timeout                  = var.delete_timeout
}

module "classic_cluster_worker_pool" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-classic-worker-pool"
  source = "../../modules/configure-classic-worker-pool"

  cluster_name       = module.classic_kubernetes_multi_zone_cluster.container_cluster_id
  worker_pool_name   = var.worker_pool_name
  worker_nodes       = var.worker_nodes
  flavor             = var.flavor
  resource_group_id  = data.ibm_resource_group.rg.id
  wait_till_albs     = var.wait_till_albs
  hardware           = var.hardware
  encrypt_local_disk = var.encrypt_local_disk
  labels             = var.labels
  create_timeout     = var.create_timeout
  update_timeout     = var.update_timeout
  delete_timeout     = var.delete_timeout
}

module "configure_sysdig_monitor" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"

  source = "../../modules/configure-sysdig-monitor"

  cluster            = module.classic_kubernetes_multi_zone_cluster.container_cluster_id
  sysdig_instance_id = var.sysdig_name != null ? data.ibm_resource_instance.sysdig_instance[0].guid : module.sysdig_instance[0].sysdig_guid
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.sysdig_access_key
}

module "configure_logdna" {
  //Uncomment the following line to make the source point to registry level
  //source = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"

  source               = "../../modules/configure-logdna"
  cluster              = module.classic_kubernetes_multi_zone_cluster.container_cluster_id
  logdna_instance_id   = var.logDNA_name != null ? data.ibm_resource_instance.logdna_instance[0].guid : module.logdna_instance[0].logdna_instance_guid
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logdna_ingestion_key
}