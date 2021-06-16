data "ibm_resource_instance" "cos_instance" {
  count             = var.cos_instance_name != null ? 1 : 0
  name              = var.cos_instance_name
  location          = "global"
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "cloud-object-storage"
}
resource "ibm_resource_instance" "cos_instance" {
  count             = var.cos_instance_name != null ? 0 : 1
  name              = "${var.resource_prefix}-cos"
  location          = "global"
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "cloud-object-storage"
  plan              = "standard"
  tags              = ["secure-roks"]
}
