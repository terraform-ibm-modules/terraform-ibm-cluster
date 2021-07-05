#####################################################
# SYSDIG Configuration
# Copyright 2021 IBM
#####################################################

module "sysdig_instance" {
  source = "terraform-ibm-modules/observability/ibm//modules/monitoring-sysdig"

  count             = var.sysdig_name == null ? 1 : 0
  bind_resource_key = true
  service_name      = "sysdig"
  resource_group_id = data.ibm_resource_group.rg.id
  plan              = "graduated-tier"
  region            = var.region
  tags              = ["FS-Cloud"]
  create_timeout    = "30m"
  resource_key_name = "sysdig-key"
  role              = "Manager"
  resource_key_tags = ["FS-Cloud"]
}

data "ibm_resource_instance" "sysdig_instance" {
  count             = var.sysdig_name != null ? 1 : 0
  name              = var.sysdig_name
  service           = "sysdig-monitor"
  resource_group_id = data.ibm_resource_group.rg.id
  location          = var.region
}