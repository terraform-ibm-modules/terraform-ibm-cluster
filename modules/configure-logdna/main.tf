#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

resource "null_resource" "setup-ob-plugin" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/setup-ob-plugin.sh"
  }
}

resource "null_resource" "logdna_bind" {
  depends_on = [null_resource.setup-ob-plugin]

  triggers = {
    cluster_id  = var.cluster_name
    instance_id = var.logdna_instance_id
  }

  provisioner "local-exec" {
    command = "${path.module}/scripts/bind-instance.sh ${self.triggers.cluster_id} ${self.triggers.instance_id}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/unbind-instance.sh ${self.triggers.cluster_id} ${self.triggers.instance_id}"
  }
}