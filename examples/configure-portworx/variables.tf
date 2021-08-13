
variable "ibmcloud_api_key" {
    default = null
    description = "Get the ibmcloud api key from https://cloud.ibm.com/iam/apikeys"
}

variable "cluster_id" {
    default = null
    description = "The id of the cluster"
}

variable "worker_nodes" {
    default = null
    type = number
    description = "Number of worker nodes"
}

variable "region" {
    default = null
    description = "The region Portworx will be installed in. To list all available regions fun `ibmcloud regions`"
}

variable "resource_group_name" {
    default = null
    description = "Resource Group in your account. List all available resource groups with: `ibmcloud resource groups`"
}

variable "unique_id" {
    description = "Unique string for naming Portworx resources"
    default     = "px-ext-portworx"
}

variable "storage_capacity"{
    type = number
    default = 200
    description = "Storage capacity in GBs"
}

variable "storage_iops" {
    type = number
    default = 10
    description = "This is used only if a user provides a custom storage_profile"
}

variable "storage_profile" {
    type = string
    default = "10iops-tier"
    description = "The is the storage profile used for creating storage"
}

variable "create_external_etcd" {
    type = bool
    default = false
    description = "Do you want to create an external_etcd? `True` or `False`"
}

# These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
# You may override these for additional security.
variable "etcd_username" {
  default = "portworxuser"
  description = "Ignored if `create_external_etcd` is `false`"
}

variable "etcd_password" {
  default = "etcdpassword123"
  description = "Ignored if `create_external_etcd` is `false`"
}

locals {
  kube_config_path = "./.kube/config"
}
