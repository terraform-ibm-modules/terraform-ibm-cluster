#####################################################
# Kubernetes classic multi-zone cluster provisioning
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

variable "hardware" {
  description = "Enter worker pool hardware type (shared / dedicated)"
  type        = string
}

variable "worker_pool_flavor" {
  description = "The machine type for your worker node."
  type        = string
  default     = null
}

variable "public_vlan_id" {
  description = "The ID of the public VLAN that you want to use for your worker nodes."
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

variable "private_vlan_id" {
  description = "The ID of the private VLAN that you want to use for your worker nodes."
  type        = string
  default     = null
}

variable "resource_group" {
  description = "Enter Name of the resource group"
  type        = string
}

variable "worker_nodes_per_zone" {
  description = "Number of workser nodes per zone"
  type        = number
  default     = null
}

variable "master_service_public_endpoint" {
  description = "Enable the public service endpoint to make the master publicly accessible."
  type        = bool
  default     = null
}

variable "worker_nodes" {
  description = "Number of worker nodes"
  type        = number
}

variable "flavor" {
  description = "Machine type."
  type        = string
}

variable "labels" {
  description = "A list of labels that you want to add to all the worker nodes in the worker pool"
  type        = map
  default     = null
}


variable "master_service_private_endpoint" {
  description = "Enable the private service endpoint to make the master privately accessible."
  type        = bool
  default     = null
}

variable "force_delete_storage" {
  description = "force the removal of persistent storage associated with the cluster during cluster deletion."
  type        = bool
  default     = null
}

variable "gateway_enabled" {
  description = "Set to true if you want to automatically create a gateway-enabled cluster."
  type        = bool
  default     = null
}

variable "encrypt_local_disk" {
  description = "Set this to true to encrypy disk."
  type        = bool
  default     = null
}

variable "no_subnet" {
  description = "If set to true, no portable subnet is created during cluster creation."
  type        = bool
  default     = null
}

variable "update_all_workers" {
  description = "set to true, the Kubernetes version of the worker nodes is updated along with the Kubernetes version of the cluster that you specify in kube_version."
  type        = bool
  default     = null
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

variable "wait_till_albs" {
  description = "specify the stage when you want Terraform to mark the zone attachment complete."
  type        = bool
  default     = null
}

variable "subnet_id" {
  description = "ID of an existing subnet that you want to use for your worker nodes."
  type        = list
  default     = null
}

variable "worker_pool_name" {
  description = "Name of the worker pool."
  type        = string
}

variable "sysdig_name" {
  type        = string
  description = "Enter the name of existing sysdig instance to attach to a cluster"
  default     = null
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

variable "logDNA_name" {
  type        = string
  description = "Enter the name of existing logdna instance to attach to a cluster"
  default     = null
}


variable "logdna_ingestion_key" {
  type        = string
  description = "LogDNA ingestion key"
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


