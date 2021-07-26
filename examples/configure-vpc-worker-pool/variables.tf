#####################################################
# vpc cluster worker-pool configuration
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string 
}


variable "worker_pool_data" {
  type        = map
  description = "List of worker pool data"
}

variable "resource_group" {
  description = "The name of resource_group"
  type        = string
}

variable "worker_zones" {
  type        = map
  description = "List of worker zones to attach"
}

variable "virtual_private_cloud" {
  description = "The ID of the VPC that you want to use for your cluster."
  type        = string
}

variable "labels" {
  description = "A list of labels that you want to add to all the worker nodes in the worker pool"
  type        = map
  default     = null
}

variable "entitlement" {
  description = "Name of entittlement, use for openshift cluster"
  type        = string
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