#####################################################
# Configure Add-ons to a cluster
# Copyright 2020 IBM
#####################################################

resource "ibm_container_addons" "addons" {
  cluster  = var.cluster_name
  for_each = var.add_ons
  addons {
    name    = each.key
    version = each.value["version"]
  }

  timeouts {
    create = (var.create_timeout != null ? var.create_timeout : null)
    update = (var.update_timeout != null ? var.update_timeout : null)
  }
}
