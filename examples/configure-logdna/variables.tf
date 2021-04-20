#####################################################
# Configure logdna to a cluster
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Enter the name of the cluster"
  type        = string
}

variable "logdna_name" {
  type        = string
  description = "Enter the name of logdna instance to attach to a cluster"
}

variable "resource_group" {
  description = "Enter the name of the resource group"
  type        = string
}

variable "region" {
  description = "Enter the region sysdig instance "
  type        = string
}



