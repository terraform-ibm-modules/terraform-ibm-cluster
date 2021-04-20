#####################################################
# Kubernetes classic free cluster provisioning
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "worker_zone" {
  description = "The zone where the worker node is created."
  type        = string
}

variable "hardware" {
  description = "The level of hardware isolation for your worker node."
  type        = string
}

