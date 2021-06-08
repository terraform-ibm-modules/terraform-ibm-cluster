######################################################
#IBM-Cloud Authentication Credentials
######################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM-Cloud API Key"
  default     = "dbBz_pGjYVInTdNz118UCJJfptTgN1H8--QQWpWq-exq"
}
variable "ibm_region" {
  type        = string
  description = "IBM-Cloud Region"
  default     = "us-south"
}
variable "resource_group" {
  type        = string
  description = "Name of Resource Group. If null default resource group is considered"
  default     = null
}

######################################################
#IBM-Cloud Object Storage Variables
######################################################
variable "cos_instance_name" {
  description = "Name of Object Storage Instance"
  type        = string
  default     = "satellite"
}

######################################################
#IBM-Cloud Cluster Variables
######################################################
variable "resource_prefix" {
  type        = string
  description = "Prefix to the resource names"
  default     = "fs"
}

variable "flavor" {
  description = "The flavor of the VPC Cluster or worker node."
  type        = string
  default     = "bx2.4x16"
}
variable "ocp_version" {
  type        = string
  description = "Specify the Openshift version"
  default     = "4.6.23_1540_openshift"
}
variable "ocp_entitlement" {
  type        = string
  description = "Value that is applied to the entitlements for OCP cluster provisioning"
  default     = "cloud_pak"
}
variable "disable_public_service_endpoint" {
  description = "Disable the public service endpoint to prevent public access to the master"
  type        = bool
  default     = false
}
variable "worker_nodes_per_zone" {
  type        = number
  description = "The number of worker nodes per zone."
  default     = 3
}
variable "create_timeout" {
  type        = string
  description = "Custom Creation timeout for Cluster"
  default     = null
}

######################################################
#IBM-Cloud IAM Policy Variables
######################################################
variable "roks_kms_policy" {
  default     = true
  description = "Determinies if Kubernetes to KMS Service Authorisation policy.If false it creates policy between services "
  type        = bool
}

######################################################
#IBM-Cloud Key Protect Variables
######################################################
variable "kms_instance" {
  description = "Name of Key Protect Instance"
  type        = string
  default     = "test_kms"
}
variable "kms_key" {
  description = "Name of Key Protect Key"
  type        = string
  default     = "test_root_key"
}

######################################################
#IBM-Cloud Logging and Monitoring Variables
######################################################
variable "sysdig_name" {
  default     = null
  type        = string
  description = "Name of Sysdig Instance. If null it creates an instance with `<var.resource_prefix>-sysdig`"
}
variable "sysdig_access_key" {
  description = "The sysdig monitoring ingestion key that you want to use for your configuration"
  type        = string
  default     = null
}
variable "logDNA_name" {
  default     = null
  type        = string
  description = "Name of logDNA_name Instance. If null it creates an instance with `<var.resource_prefix>-logdna`"
}
variable "logdna_ingestion_key" {
  description = "The LogDNA ingestion key that you want to use for your configuration"
  type        = string
  default     = null
}
variable "private_endpoint" {
  description = "Add this option to connect to your Sysdig and logDNA service instance through the private service endpoint."
  type        = string
  default     = null
}

