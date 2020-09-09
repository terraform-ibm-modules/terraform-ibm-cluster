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

variable "worker_nodes_per_zone"{
    description = "Number of worker nodes per zone"
    type        = number
}


variable "resource_group_id" {
    description = "ID of resource group."
    type        = string
}


variable "worker_pool_flavor" {
    description = "The machine type for your worker node."
    type        = string
}

variable "public_vlan" {
    description = "The ID of the public VLAN that you want to use for your worker nodes."
    type        = string
}

variable "private_vlan" {
    description = "The ID of the private VLAN that you want to use for your worker nodes."
    type        = string
}

variable "hardware" {
    description = "The level of hardware isolation for your worker node."
    type        = string
}

variable "master_service_public_endpoint" {
    description = "Enable the public service endpoint to make the master publicly accessible."
    type        = bool
}

variable "force_delete_storage" {
    description = "force the removal of persistent storage associated with the cluster during cluster deletion."
    type        = bool
}

variable "gateway_enabled" {
    description = "Set to true if you want to automatically create a gateway-enabled cluster."
    type        = bool
}

variable "master_service_private_endpoint" {
    description = "Enable the private service endpoint to make the master privately accessible."
    type        = bool
}

variable "encrypt_local_disk" {
    description = "Set this to true to encrypy disk."
    type        = bool
}

variable "no_subnet" {
    description = "If set to true, no portable subnet is created during cluster creation."
    type        = bool
}

variable "update_all_workers" {
    description = "set to true, the Kubernetes version of the worker nodes is updated along with the Kubernetes version of the cluster that you specify in kube_version."
    type        = bool
}

variable "wait_till_albs" {
    description = "specify the stage when you want Terraform to mark the zone attachment complete."
    type        = bool
}

variable "kube_version" {
    description = "The Kubernetes or OpenShift version that you want to set up in your cluster."
    type        = string
}

variable "tags" {
    description = "List of tags."
    type        = list(string)
    default     = []
}

variable "subnet_id" {
    description = "ID of an existing subnet that you want to use for your worker nodes."
    type        = list
}

variable "worker_zones" {
  type = map
  default = {}
}

variable "kms_config" {
  type = list(map(string))
  default = []
}

variable "workers_info" {
  type = list(map(string))
  default = []
}

variable "webhook" {
  type = list(map(string))
  default = []
}






