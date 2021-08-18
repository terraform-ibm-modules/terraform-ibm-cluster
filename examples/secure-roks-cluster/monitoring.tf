module "monitoring_instance" {
  source = "terraform-ibm-modules/observability/ibm//modules/monitoring-sysdig"

  count             = var.monitoring_instance == null ? 1 : 0
  bind_resource_key = true
  service_name      = "${var.resource_prefix}-monitoring"
  resource_group_id = data.ibm_resource_group.resource_group.id
  plan              = "lite"
  region            = var.region
  tags              = ["secure-roks", var.resource_prefix]
  create_timeout    = "30m"
  resource_key_name = "${var.resource_prefix}-monitoring-key"
  role              = "Manager"
  resource_key_tags = ["secure-roks", var.resource_prefix]
  parameters = {
    default_receiver = true #enable for platform metrics
  }
}
