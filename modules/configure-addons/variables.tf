#####################################################
# Configure Add-ons to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "add_ons" {
  type    = map
  default = {}
}

variable "create_timeout" {
  type        = string
  description = "Timeout duration for create."
  default     = null
}

variable "update_timeout" {
  type        = string
  description = "Timeout duration for update."
  default     = null
}



