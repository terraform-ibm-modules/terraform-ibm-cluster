######################################################
#IBM-Cloud Authentication Credentials
######################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM-Cloud API Key"
}
variable "region" {
  type        = string
  description = "IBM-Cloud Region"
}
variable "resource_group" {
  type        = string
  description = "Name of Resource Group. If null default resource group is considered"
  default     = null
}

######################################################
#IBM-Cloud Object Storage Variables
######################################################
variable "cos_instance" {
  description = "CRN of Object Storage Instance. If null it creates an instance with `<var.resource_prefix>-cos"
  type        = string
  default     = null
}

######################################################
#IBM-Cloud Cluster Variables
######################################################
variable "resource_prefix" {
  type        = string
  description = "Prefix to the resource names"
}
variable "flavor" {
  description = "The flavor of the VPC Cluster or worker node."
  type        = string
  default     = "bx2.4x16"
}
variable "ocp_version" {
  type        = string
  description = "Specify the Openshift version"
  default     = "4.6_openshift"
}
variable "ocp_entitlement" {
  type        = string
  description = "Value that is applied to the entitlements for OCP cluster provisioning"
  default     = "cloud_pak"
}
variable "disable_public_service_endpoint" {
  description = "Disable the public service endpoint to prevent public access to the master"
  type        = bool
  default     = true
}
variable "worker_nodes_per_zone" {
  type        = number
  description = "The number of worker nodes per zone."
  default     = 3
}
variable "wait_till" {
  description = "specify the stage when Terraform to mark the cluster creation as completed."
  type        = string
  default     = "ingressReady"
}
variable "create_timeout" {
  type        = string
  description = "Custom Creation timeout for Cluster"
  default     = "3h"
}

######################################################
#IBM-Cloud IAM Policy Variables
######################################################
variable "roks_kms_policy" {
  default     = true
  description = "Determinies if Kubernetes to KMS Service Authorisation policy exists.If false it creates policy between services "
  type        = bool
}

######################################################
#IBM-Cloud Key Protect Variables
######################################################
variable "kms_instance" {
  description = "GUID of Key Protect Instance. If null it creates an instance with name `<var.resource_prefix>-kp`"
  type        = string
  default     = null
}
variable "kms_key" {
  description = "Key ID of Key Protect Key. If null it creates an instance with name `<var.resource_prefix>-kp-key`"
  type        = string
  default     = null
}

variable "standard_key_type" {
  description = "Determines if it is a standard key or not." // This variable is used during creation of KP Key.
  default     = false
  type        = bool
}
######################################################
#IBM-Cloud Logging and Monitoring Variables
######################################################
variable "monitoring_instance" {
  default     = null
  type        = string
  description = "GUID of Sysdig Instance. If null it creates an instance with name `<var.resource_prefix>-sysdig`"
}
variable "monitoring_access_key" {
  description = "The sysdig monitoring ingestion key that you want to use for your configuration"
  type        = string
  default     = null
}
variable "logging_instance" {
  default     = null
  type        = string
  description = "GUID of Logging Instance. If null it creates an instance with `<var.resource_prefix>-logdna`"
}
variable "logging_ingestion_key" {
  description = "The LogDNA ingestion key that you want to use for your configuration"
  type        = string
  default     = null
}
variable "private_endpoint" {
  description = "Add this option to connect to your Sysdig and logDNA service instance through the private service endpoint."
  type        = bool
  default     = true
}
variable "activity_tracker_instance" {
  description = "GUID of Activity Tracker Instance. If null it doesnt create activity tracker instance."
  default     = null
  type        = string
}
######################################################
#IBM-Cloud Network Variables
######################################################
variable "custom_sg_rules" {
  description = "Custom Security rules"
  type        = any // Refer README for type
  default     = []
}
variable "ip_ranges" {
  description = "Ordered List of ip_ranges on which subnets has to be created. Conflicts with number_of_addresses argument"
  type        = list(string)
  default     = null
}
variable "number_of_addresses" {
  description = "Number of IPV4 Addresses. Conflicts with ip_ranges argument"
  type        = number
  default     = null
}