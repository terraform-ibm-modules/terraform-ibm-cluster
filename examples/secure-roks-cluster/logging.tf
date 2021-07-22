module "logdna_instance" {
  source = "terraform-ibm-modules/observability/ibm//modules/logging-logdna"

  count             = var.logdna_name == null ? 1 : 0
  bind_resource_key = true
  service_name      = "${var.resource_prefix}-logdna"
  resource_group_id = data.ibm_resource_group.resource_group.id
  plan              = "30-day"
  region            = var.region
  tags              = ["secure-roks"]
  create_timeout    = "30m"
  resource_key_name = "${var.resource_prefix}-logdna-key"
  role              = "Manager"
  resource_key_tags = ["secure-roks"]
  parameters = {
    default_receiver = true #enable for platform metrics
  }
}
data "ibm_resource_instance" "logdna_instance" {
  count             = var.logdna_name != null ? 1 : 0
  name              = var.logdna_name
  service           = "logdna"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.region
}
