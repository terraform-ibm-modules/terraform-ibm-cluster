#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
}

variable "cluster" {
  description = "Cluster Name"
  type        = string

  validation {
    error_message = "Cluster name must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.cluster))
  }
}

variable "namespace" {
  type        = string
  description = "Namespace name"
  default     = "default"

  validation {
    error_message = "Cluster name must begin and end with a letter and contain only letters, numbers, and - characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.namespace))
  }
}

variable "route_data" {
  description = "Route specification"
  default     = <<EOT
  {
   "kind":"Route",
   "apiVersion":"route.openshift.io/v1",
   "metadata":{
      "name":"route-01"
   },
   "spec":{
      "to":{
         "kind":"Service",
         "name":"nginx-service"
      },
      "port":{
         "targetPort":"https"
      },
      "tls":{
         "termination":"passthrough"
      }
   }
}
EOT
}