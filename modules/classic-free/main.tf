#####################################################
# Kubernetes classic free cluster
# Copyright 2020 IBM
#####################################################
resource "ibm_container_cluster" "cluster" {
  name              = var.cluster_name
  datacenter        = var.worker_zone
  hardware          = var.hardware
  machine_type      = "free"
}