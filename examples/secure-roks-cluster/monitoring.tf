module "sysdig_instance" {
  source = "terraform-ibm-modules/observability/ibm//modules/monitoring-sysdig"

  count             = var.sysdig_name == null ? 1 : 0
  bind_resource_key = true
  service_name      = "${var.resource_prefix}-sysdig"
  resource_group_id = data.ibm_resource_group.resource_group.id
  plan              = "graduated-tier"
  region            = var.ibm_region
  tags              = ["FS-Cloud"]
  create_timeout    = "30m"
  resource_key_name = "${var.resource_prefix}-sysdig-key"
  role              = "Manager"
  resource_key_tags = ["FS-Cloud"]
}
data "ibm_resource_instance" "sysdig_instance" {
  count             = var.sysdig_name != null ? 1 : 0
  name              = var.sysdig_name
  service           = "sysdig-monitor"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.ibm_region
}