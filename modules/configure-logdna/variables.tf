#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "logdna_instance_id" {
  type        = string
  description = "Sysdig instance id to attach to a cluster"
}




