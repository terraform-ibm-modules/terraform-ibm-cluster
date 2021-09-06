locals {
  sysdig_instance_id = var.monitoring_instance != null ? var.monitoring_instance : module.monitoring_instance[0].sysdig_guid
  logdna_instance_id = var.logging_instance != null ? var.logging_instance : module.logging_instance[0].logdna_instance_guid
}
