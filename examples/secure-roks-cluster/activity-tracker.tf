resource "ibm_resource_instance" "activity_tracker_instance" {
  count             = var.activity_tracker_instance_name != null ? 1 : 0
  name              = var.activity_tracker_instance_name
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "logdnaat"
  plan              = "lite"
  tags              = ["secure-roks"]
}
