data "ibm_resource_instance" "kms_instance" {
  count             = var.kms_instance != null ? 1 : 0
  name              = var.kms_instance
  service           = "kms"
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.ibm_region
}
data "ibm_kms_key" "kms_key" {
  count       = var.kms_instance != null && var.kms_key != null ? 1 : 0
  instance_id = data.ibm_resource_instance.kms_instance[0].guid
  key_name    = var.kms_key
}
