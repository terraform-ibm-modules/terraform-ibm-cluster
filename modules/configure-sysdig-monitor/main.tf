#####################################################
# Configure sysdig monitor to a cluster
# Copyright 2020 IBM
#####################################################

resource "ibm_ob_monitoring" "sysdig" {
  cluster           = var.cluster
  instance_id       = var.sysdig_instance_id
  sysdig_access_key = var.sysdig_access_key != null ? var.sysdig_access_key : null
  private_endpoint  = var.private_endpoint != null ? var.private_endpoint : null

  timeouts {
    create = (var.create_timeout != null ? var.create_timeout : null)
    update = (var.update_timeout != null ? var.update_timeout : null)
    delete = (var.delete_timeout != null ? var.delete_timeout : null)
  }
}