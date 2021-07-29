#########################################################################################
# IBM Cloud Key Management Services Provisioning and Managing Keys
# Copyright 2021 IBM
#########################################################################################

########################### KMS #########################################################

variable "resource_group" {
  type        = string
  description = "Resource group of instance"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "service_name" {
  type        = string
  description = "Name of KMS Instance"
}
variable "location" {
  type        = string
  description = "Location of KMS Instance"
}
variable "allowed_network_policy" {
  default     = null
  type        = string
  description = "Types of the service endpoints. Possible values are 'private', 'public-and-private'."
}
variable "kms_tags" {
  default     = ["T1", "T2"]
  type        = set(string)
  description = "Tags for the cms"
}
variable "key_name" {
  description = "Name of the Key"
  type        = string
}
variable "network_access_allowed" {
  description = "Endpoint type of the Key"
  type        = string
  default     = null
}
variable "standard_key_type" {
  description = "Determines if it is a standard key or not"
  default     = null
  type        = bool
}
variable "force_delete" {
  description = "Determines if it has to be force deleted"
  default     = null
  type        = bool
}

#########################################################################
#  cos
#########################################################################

variable "cos_instance_name" {
  description = "Enter Name of the cos instance"
  type        = string
}

variable "plan" {
  description = "Enter COS plan type"
  type        = string
}

variable "region" {
  description = " Enter Region for COS"
  type        = string
}

variable "parameters" {
  type        = map(string)
  description = "Arbitrary parameters to pass cos instance"
  default = {
    service-endpoints = "private"
  }
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

#########################################################################
#  IAM Authorization
#########################################################################

variable "iam_roles" {
  type        = list(string)
  description = "Enter comma separated list of roles."
  default     = ["Reader"]
}

#########################################################################
#  VPC Cluster
#########################################################################

variable unique_id {
  description = "A unique identifier need to provision resources. Must begin with a letter"
  type        = string
  default     = "asset-roks"

  validation {
    error_message = "Unique ID must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.unique_id))
  }
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "worker_pool_flavor" {
  description = " The flavor of the VPC worker node that you want to use."
  type        = string
}

variable "worker_nodes_per_zone" {
  description = "The number of worker nodes per zone in the default worker pool."
  type        = number
}

variable "kube_version" {
  description = "The Kubernetes or OpenShift version that you want to set up in your cluster."
  type        = string
  default     = "4.6.38_openshift"
}

variable "wait_till" {
  description = "specify the stage when Terraform to mark the cluster creation as completed."
  type        = string
  default     = "IngressReady"
}

variable "disable_public_service_endpoint" {
  description = "Boolean value true if Public service endpoint to be disabled."
  type        = bool
  default     = false
}

variable "cluster_tags" {
  description = "List of tags."
  type        = list(string)
  default     = []
}

variable "entitlement" {
  description = "If you purchased an IBM Cloud Cloud Pak that includes an entitlement to run worker nodes that are installed with OpenShift Container Platform, enter entitlement to create your cluster with that entitlement so that you are not charged twice for the OpenShift license. Note that this option can be set only when you create the cluster. After the cluster is created, the cost for the OpenShift license occurred and you cannot disable this charge."
  type        = string
  default     = "cloud_pak"
}

###################### Worker Pool ################################

variable worker_pool_data {
  description = "List of maps describing worker pools"

  type = list(object({
    pool_name        = string
    machine_type     = string
    workers_per_zone = number
  }))

  default = [
    {
      pool_name        = "dev"
      machine_type     = "cx2.8x16"
      workers_per_zone = 2
    },
    {
      pool_name        = "test"
      machine_type     = "mx2.4x32"
      workers_per_zone = 2
    }
  ]

  validation {
    error_message = "Worker pool names must match the regex `^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$`."
    condition = length([
      for pool in var.worker_pool_data :
      false if ! can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", pool.pool_name))
    ]) == 0
  }

  validation {
    error_message = "Worker pools cannot have duplicate names."
    condition = length(distinct([
      for pool in var.worker_pool_data :
      pool.pool_name
    ])) == length(var.worker_pool_data)
  }

}

variable subnet_names {
  description = "List of subnet names or IDs"
  type        = list(string)
  validation {
    error_message = "Subnet names must match the regex `^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$`."
    condition = length([
      for name in var.subnet_names :
      false if ! can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", name))
    ]) == 0
  }

  validation {
    error_message = "Subnet names must include at least one subnet."
    condition     = length(var.subnet_names) > 0
  }

  validation {
    error_message = "Subnet names cannot contain any duplicate names."
    condition     = length(distinct(var.subnet_names)) == length(var.subnet_names)
  }

}