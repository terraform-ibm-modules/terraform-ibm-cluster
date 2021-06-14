#####################################################
# Configure Sysdif monitor to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster" {
  description = "Enter the name or id of the cluster"
  type        = string
}

variable "sysdig_name" {
  type        = string
  description = "Enter the name of Sysdig instance to attach to a cluster"
}

variable "resource_group" {
  description = "Enter the name of the resource group"
  type        = string
}

variable "region" {
  description = "Enter the region sysdig instance "
  type        = string
}

variable "private_endpoint" {
  description = "Add this option (true/false) to connect to your LogDNA service instance through the private service endpoint"
  type        = bool
  default     = null
}

variable "sysdig_access_key" {
  type        = string
  description = "sysdig access key"
  default     = null
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

variable "delete_timeout" {
  type        = string
  description = "Timeout duration for delete."
  default     = null
}




