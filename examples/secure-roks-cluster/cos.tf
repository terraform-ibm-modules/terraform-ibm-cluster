resource "ibm_resource_instance" "cos_instance" {
  count             = var.cos_instance != null ? 0 : 1
  name              = "${var.resource_prefix}-cos"
  location          = "global"
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "cloud-object-storage"
  plan              = "standard"
  tags              = ["secure-roks", var.resource_prefix]
}
