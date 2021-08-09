resource "ibm_resource_instance" "activity_tracker_instance" {
  count             = var.activity_tracker_instance != null ? 0 : 1
  name              = "${var.resource_prefix}-at"
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "logdnaat"
  plan              = "lite"
  tags              = ["secure-roks", var.resource_prefix]
}
