#####################################################
# ibm_container_alb_cert - Used to create SSL certificate that
# you store in IBM Cloud Certificate Manager for an Ingress Application Load Balancer (ALB).
# Copyright 2020 IBM
#####################################################

variable "certificate_crn" {
  description = "The CRN of the certificate that you uploaded to IBM Cloud Certificate Manager."
  type        = string
}

variable "cluster" {
  description = "The ID or name of the cluster that hosts the Ingress ALB that you want to configure for SSL traffic."
  type        = string
}

variable "secret_name" {
  description = "The name of the ALB certificate secret."
  type        = string
}

variable "namespace" {
  description = "The namespace in which the secret is created. Default value is ibm-cert-store"
  type        = string
  default     = "ibm-cert-store"
}

variable "persistence" {
  type        = bool
  description = "Persist the secret data in your cluster. If the secret is later deleted from the command line or OpenShift web console, the secret is automatically re-created in your cluster."
  default     = null
}

