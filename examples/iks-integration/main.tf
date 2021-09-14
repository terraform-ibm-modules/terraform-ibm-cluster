module "configure_cluster_sysdig" {
  source             = "terraform-ibm-modules/cluster/ibm//modules/configure-sysdig-monitor"
  count              = var.monitoring_instance == null ? 0 : 1
  version            = "1.4.0"
  depends_on         = [module.configure_cluster_logdna]
  cluster            = var.cluster
  sysdig_instance_id = var.monitoring_instance
  private_endpoint   = var.private_endpoint
  sysdig_access_key  = var.monitoring_access_key
}

module "configure_cluster_logdna" {
  source               = "terraform-ibm-modules/cluster/ibm//modules/configure-logdna"
  count                = var.logging_instance == null ? 0 : 1
  version              = "1.4.0"
  cluster              = var.cluster
  logdna_instance_id   = var.logging_instance
  private_endpoint     = var.private_endpoint
  logdna_ingestion_key = var.logging_ingestion_key
}

module "patch_monitoring" {
  source     = "./patch-sysdig"
  count      = var.monitoring_instance == null ? 0 : 1
  depends_on = [module.configure_cluster_sysdig]
  cluster    = var.cluster
}