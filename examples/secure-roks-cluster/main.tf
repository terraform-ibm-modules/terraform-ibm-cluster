data "ibm_resource_group" "resource_group" {
  name       = (var.resource_group != null ? var.resource_group : null)
  is_default = (var.resource_group == null ? true : null)
}

module "vpc_ocp_cluster" {
  source = "terraform-ibm-modules/cluster/ibm//modules/vpc-openshift"

  cluster_name                    = "${var.resource_prefix}-cluster"
  vpc_id                          = module.vpc.vpc_id
  worker_pool_flavor              = var.flavor
  resource_group_id               = data.ibm_resource_group.resource_group.id
  kube_version                    = var.ocp_version
  worker_zones                    = local.worker_zones
  worker_nodes_per_zone           = var.worker_nodes_per_zone
  tags                            = ["fs-cloud", "cluster"]
  disable_public_service_endpoint = var.disable_public_service_endpoint
  entitlement                     = var.ocp_entitlement
  cos_instance_crn                = local.cos_crn
  kms_config                      = local.kms_config
}
module "vpc_ocp_cluster_worker_pool" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-vpc-worker-pool"

  cluster_name          = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  worker_pool_name      = "${var.resource_prefix}-worker-pool"
  worker_nodes_per_zone = var.worker_nodes_per_zone
  flavor                = var.flavor
  resource_group_id     = data.ibm_resource_group.resource_group.id
  virtual_private_cloud = module.vpc.vpc_id
  worker_zones          = local.pool_worker_zones
  labels                = { worker-pool = var.resource_prefix }
  entitlement           = var.ocp_entitlement
}
module "configure_cluster_sysdig" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"

  cluster            = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  sysdig_instance_id = local.sysdig_instance_id
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.sysdig_access_key
}
module "configure_cluster_logdna" {
  source = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"

  cluster              = module.vpc_ocp_cluster.vpc_openshift_cluster_id
  logdna_instance_id   = local.logdna_instance_id
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logdna_ingestion_key
}

