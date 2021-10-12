#####################################################
# Openshift cluster route provisioning
# Copyright 2021 IBM
#####################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud api key"
}

variable "cluster_service_url" {
  type        = string
  description = "Cluster service url"
}

variable "namespace" {
  type        = string
  description = "Namespace name."
}

variable "route_data" {
  type        = string
  description = "Openshift Route specification."
}

