#####################################################
# Classic kubernetes cluster configurations
# Copyright 2020 IBM
#####################################################

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "worker_pool_name" {
  description = "Name of the worker pool."
  type        = string
}

variable "worker_nodes" {
  description = "Number of worker nodes"
  type        = number
}

variable "flavor" {
  description = "Machine type."
  type        = string
}

variable "hardware" {
  description = "The level of hardware isolation for your worker node."
  type        = string
  default     = null
}


variable "encrypt_local_disk" {
  description = "Set this to true to enable disk encryption"
  type        = bool
  default     = null
}

variable "worker_zones" {
  type        = map
  description = "List of worker zones to attach"
}

variable "resource_group" {
  description = "Enter Name of the resource group"
  type        = string
}

variable "labels" {
  description = "A list of labels that you want to add to all the worker nodes in the worker pool"
  type        = map
  default     = null
}

variable "wait_till_albs" {
  description = "specify the stage when you want Terraform to mark the zone attachment complete."
  type        = bool
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

variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Set taints to worker nodes."
  default = [{
    key    = "dedicated"
    value  = "edge"
    effect = "NoSchedule"
    },
  ]
}
