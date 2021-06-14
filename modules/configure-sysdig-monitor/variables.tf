#####################################################
# Configure Sysdif monitor to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster" {
  description = "Name or id of the cluster"
  type        = string
}

variable "sysdig_instance_id" {
  type        = string
  description = "Sysdig instance id to attach to a cluster"
}

variable "private_endpoint" {
  description = "Add this option to connect to your LogDNA service instance through the private service endpoint"
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



