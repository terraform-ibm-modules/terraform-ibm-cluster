######################################################
#IBM-Cloud Authentication Credentials
######################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM-Cloud API Key"
}

######################################################
#IBM-Cloud Logging and Monitoring Variables
######################################################
variable "cluster" {
  type        = string
  description = "Id of cluster"
}
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