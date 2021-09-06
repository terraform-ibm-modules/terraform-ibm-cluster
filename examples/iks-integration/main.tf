data "ibm_resource_group" "resource_group" {
  name       = (var.resource_group != null ? var.resource_group : null)
  is_default = (var.resource_group == null ? true : null)
}

module "configure_cluster_sysdig" {
  source             = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"
  version            = "1.4.0"
  depends_on         = [module.configure_cluster_logdna]
  cluster            = var.cluster
  sysdig_instance_id = local.sysdig_instance_id
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.monitoring_access_key
}

module "configure_cluster_logdna" {
  source               = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"
  version              = "1.4.0"
  cluster              = var.cluster
  logdna_instance_id   = local.logdna_instance_id
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logging_ingestion_key
}

module "patch_monitoring" {
  source            = "./patch-sysdig"
  depends_on        = [module.configure_cluster_sysdig]
  cluster           = var.cluster
  resource_group_id = data.ibm_resource_group.resource_group.id
}