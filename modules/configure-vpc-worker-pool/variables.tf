#####################################################
# VPC cluster worker pool configuration
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


variable "resource_group_id" {
  description = "ID of resource group."
  type        = string
}

variable "worker_zones" {
  type    = map
  default = {}
}

variable "virtual_private_cloud" {
  description = "The ID of the VPC that you want to use for your cluster."
  type        = string
}

variable "labels" {
  type    = map
  default = {}
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

