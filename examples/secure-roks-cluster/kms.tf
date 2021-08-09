module "kms" {
  count                = var.kms_instance == null && var.kms_key == null ? 1 : 0
  source               = "terraform-ibm-modules/kms/ibm//modules/key-protect"
  is_kp_instance_exist = false
  resource_group_id    = data.ibm_resource_group.resource_group.id
  service_name         = "${var.resource_prefix}-kp"
  location             = var.region
  plan                 = "tiered-pricing"
  tags                 = ["secure-roks", var.resource_prefix]
  key_name             = "${var.resource_prefix}-kp-key"
  standard_key_type    = var.standard_key_type
}
