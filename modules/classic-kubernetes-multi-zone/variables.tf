#####################################################
# multi-zone classic cluster
# Copyright 2020 IBM
#####################################################


variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "metro" {
  description = "The zone where the worker node is created."
  type        = string
}

variable "worker_nodes_per_zone" {
  description = "Number of worker nodes per zone"
  type        = number
  default     = 1
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

variable "resource_group_id" {
  description = "ID of resource group."
  type        = string
  default     = null
}

variable "worker_pool_flavor" {
  description = "The machine type for your worker node."
  type        = string
  default     = null
}

variable "public_vlan" {
  description = "The ID of the public VLAN that you want to use for your worker nodes."
  type        = string
  default     = null
}

variable "private_vlan" {
  description = "The ID of the private VLAN that you want to use for your worker nodes."
  type        = string
  default     = null
}

variable "hardware" {
  description = "The level of hardware isolation for your worker node."
  type        = string
}

variable "master_service_public_endpoint" {
  description = "Enable the public service endpoint to make the master publicly accessible."
  type        = bool
  default     = null
}

variable "force_delete_storage" {
  description = "force the removal of persistent storage associated with the cluster during cluster deletion."
  type        = bool
  default     = false
}

variable "gateway_enabled" {
  description = "Set to true if you want to automatically create a gateway-enabled cluster."
  type        = bool
  default     = false
}

variable "master_service_private_endpoint" {
  description = "Enable the private service endpoint to make the master privately accessible."
  type        = bool
  default     = null
}

variable "encrypt_local_disk" {
  description = "Set this to true to encrypy disk."
  type        = bool
  default     = true
}

variable "no_subnet" {
  description = "If set to true, no portable subnet is created during cluster creation."
  type        = bool
  default     = false
}

variable "update_all_workers" {
  description = "set to true, the Kubernetes version of the worker nodes is updated along with the Kubernetes version of the cluster that you specify in kube_version."
  type        = bool
  default     = false
}

variable "wait_till_albs" {
  description = "specify the stage when you want Terraform to mark the zone attachment complete."
  type        = bool
  default     = true
}

variable "kube_version" {
  description = "The Kubernetes or OpenShift version that you want to set up in your cluster."
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tags."
  type        = list(string)
  default     = null
}

variable "subnet_id" {
  description = "ID of an existing subnet that you want to use for your worker nodes."
  type        = list
  default     = null
}

variable "worker_zones" {
  type    = map
  default = {}
}

variable "kms_config" {
  type    = list(map(string))
  default = []
}

variable "workers_info" {
  type    = list(map(string))
  default = []
}

variable "webhook" {
  type    = list(map(string))
  default = []
}

variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Set taints to worker nodes."
  default     = null
}







