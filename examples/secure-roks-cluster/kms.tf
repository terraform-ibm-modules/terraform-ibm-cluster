# module "kms" {
#   count                = var.kms_instance == null && var.kms_key == null ? 1 : 0
#   source               = "terraform-ibm-modules/kms/ibm//modules/key-protect"
#   version              = "1.1.0"
  # is_kp_instance_exist = false
  # resource_group_id    = data.ibm_resource_group.resource_group.id
  # service_name         = "${var.resource_prefix}-kp"
  # location             = var.region
  # plan                 = "tiered-pricing"
  # tags                 = ["secure-roks", var.resource_prefix]
#   key_name             = "${var.resource_prefix}-kp-key"
#   standard_key_type    = var.standard_key_type
# }

# LMA
resource "ibm_resource_instance" "kms" {
  count             = var.kms_instance == null && var.kms_key == null ? 1 : 0
  resource_group_id = data.ibm_resource_group.resource_group.id
  name              = "${var.resource_prefix}-kp"
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.region
  tags              = ["secure-roks", var.resource_prefix]
  service_endpoints = "private"
}

resource "ibm_kms_key" "key" {
  instance_id  = ibm_resource_instance.kms.guid
  key_name     = "${var.resource_prefix}-kp-key"
  standard_key = var.standard_key_type
}
