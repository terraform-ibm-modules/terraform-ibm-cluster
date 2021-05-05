#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster" {
  description = "Name or id of the cluster"
  type        = string
}

variable "logdna_instance_id" {
  type        = string
  description = "Sysdig instance id to attach to a cluster"
}

variable "private_endpoint" {
  description = "Add this option to connect to your LogDNA service instance through the private service endpoint"
  type        = bool
  default     = null
}

variable "logdna_ingestion_key" {
  type        = string
  description = "LogDNA ingestion key"
  default     = null
}




